import 'package:flutter/material.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../services/apple_auth_services.dart';

class AppleAuthScreen extends StatefulWidget {
  const AppleAuthScreen({super.key});

  @override
  State<AppleAuthScreen> createState() => _AppleAuthScreenState();
}

class _AppleAuthScreenState extends State<AppleAuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SignInWithAppleButton(
            onPressed: () async {
              final credential = await AppleAuthServices.signIn();

              print(credential);

              // Send the credential to your server for validation and session creation
            },
          ),
        ),
      ),
    );
  }
}
