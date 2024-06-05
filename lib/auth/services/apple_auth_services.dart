import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleAuthServices {
  static Future<User?> signIn() async {
    try {
      /// You have to put your service id here which you can find in previous steps
      /// or in the following link: https://developer.apple.com/account/resources/identifiers/list/serviceId
      String clientID = 'com.example.bmpMusic-service';

      /// Now you have to put the redirectURL which you received from Glitch Server
      /// make sure you only copy the part till "https://<GLITCH PROVIDED UNIQUE NAME>.glitch.me/"
      /// and append the following part to it "callbacks/sign_in_with_apple"
      ///
      /// It will look something like this
      /// https://<GLITCH PROVIDED UNIQUE NAME>.glitch.me/callbacks/sign_in_with_apple
      String redirectURL =
          'https://music-app-9ee48.firebaseapp.com/__/auth/handler';

      /// Generates a Random String from 1-9 and A-Z characters.
      final rawNonce = generateNonce();

      /// We are convering that rawNonce into SHA256 for security purposes
      /// In our login.
      final nonce = sha256ofString(rawNonce);

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        /// Scopes are the values that you are requiring from
        /// Apple Server.
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: Platform.isIOS ? nonce : null,

        /// We are providing Web Authentication for Android Login,
        /// Android uses web browser based login for Apple.
        webAuthenticationOptions: Platform.isIOS
            ? null
            : WebAuthenticationOptions(
                clientId: clientID,
                redirectUri: Uri.parse(redirectURL),
              ),
      );

      final AuthCredential appleAuthCredential =
          OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        rawNonce: Platform.isIOS ? rawNonce : null,
        accessToken: Platform.isIOS ? null : appleCredential.authorizationCode,
      );

      /// Once you are successful in generating Apple Credentials,
      /// We pass them into the Firebase function to finally sign in.
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(appleAuthCredential);

      return userCredential.user;
    } catch (e) {
      rethrow;
    }
  }

  static String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  static String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
