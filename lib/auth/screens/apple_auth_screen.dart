import 'package:bmp_music/auth/services/apple_auth_services.dart';
import 'package:flutter/material.dart';

class AppleAuthScreen extends StatefulWidget {
  const AppleAuthScreen({super.key});

  @override
  State<AppleAuthScreen> createState() => _AppleAuthScreenState();
}

class _AppleAuthScreenState extends State<AppleAuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apple Music Login'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final result = await AppleAuthServices.signIn();

            // final token = await getDeveloperToken();
            // // Use the token for further actions
            debugPrint('AUTH RESULT: ${result?.refreshToken}');
          },
          child: const Icon(
            Icons.download_rounded,
          ),
        ),
      ),
    );
  }
}
