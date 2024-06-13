import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleAuthServices {
  static Future<void> signIn() async {
    try {
      const String clientID = 'com.musicpacemaker.app-service';
      const String redirectURL =
          'https://valley-amplified-fright.glitch.me/callbacks/sign_in_with_apple';

      // Generate a raw nonce
      final rawNonce = generateNonce();
      // Create a SHA256 nonce for security
      final nonce = sha256ofString(rawNonce);

      // Sign in with Apple
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: Platform.isIOS ? nonce : null,
        webAuthenticationOptions: Platform.isIOS
            ? null
            : WebAuthenticationOptions(
                clientId: clientID,
                redirectUri: Uri.parse(redirectURL),
              ),
      );

      // Create Apple credential for Firebase Authentication
      final AuthCredential appleAuthCredential =
          OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        rawNonce: Platform.isIOS ? rawNonce : null,
        accessToken: Platform.isIOS ? null : appleCredential.authorizationCode,
      );

      // Sign in to Firebase with Apple credential
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(appleAuthCredential);

      if (userCredential.user != null) {
        // Reference to user's document in Firestore
        final userDocRef = FirebaseFirestore.instance
            .collection("users")
            .doc(userCredential.user!.uid);
        // Check if the user document exists
        final userDocSnapshot = await userDocRef.get();

        if (userDocSnapshot.exists == false) {
          // User doesn't exist, create new document
          await userDocRef.set(
            {
              'id': userCredential.user?.uid,
              'email': userCredential.user?.email,
              'musicUserToken': null,
              'expirationTime': null,
            },
          );
        }

        // Call Cloud Function to get Music User Token
        HttpsCallable callable =
            FirebaseFunctions.instance.httpsCallable('getMusicUserToken');

        await callable.call({
          'authorizationCode': appleCredential.authorizationCode,
        });
      } else {
        // Handle case where user is null after sign in
        debugPrint("ERROR: User is null after sign in.");
      }
    } catch (e) {
      // Catch any errors that occur during sign-in process and print them
      debugPrint("ERROR: ${e.toString()}");
    }
  }

  // Utility function to generate a random nonce
  static String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  // Utility function to create SHA256 hash of a string
  static String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  // Sign out method to sign out from Firebase
  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
