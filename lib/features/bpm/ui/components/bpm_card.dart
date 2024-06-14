import 'package:bmp_music/features/bpm/notifiers/bpm_notifier.dart';
import 'package:bmp_music/features/bpm/ui/screens/bpm_settings_screen.dart';
import 'package:bmp_music/utils/color_utils.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class BPMCard extends StatelessWidget {
  const BPMCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: ColorUtils.lightGrey,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "BPM",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: ColorUtils.lightBlack,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                context.watch<BPMNotifier>().value.toString(),
                style: const TextStyle(
                  fontSize: 56,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () async {
                  // HttpsCallable callable = FirebaseFunctions.instance
                  //     .httpsCallable('getMusicUserToken');

                  // final result = await callable.call(
                  //   {
                  //     'user': FirebaseAuth.instance.currentUser?.uid,
                  //     'authorizationCode': "appleCredential.authorizationCode",
                  //   },
                  // );

                  // debugPrint("RESULT ${result.data}");

                  callCloudFunction();
                  // Get.to(
                  //   () => const BPMSettingsScreen(),
                  //   transition: Transition.rightToLeft,
                  //   duration: const Duration(milliseconds: 700),
                  // );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorUtils.lightRed,
                    borderRadius: BorderRadius.circular(64.0),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "BPMの変更",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// Example function to call Cloud Function using Dio
  Future<void> callCloudFunction() async {
    try {
      Dio dio = Dio();
      const url =
          'https://us-central1-music-app-9ee48.cloudfunctions.net/getMusicUserToken'; // Replace with your Cloud Function URL

      // Prepare data to send in the request body
      Map<String, dynamic> requestBody = {
        'user': FirebaseAuth.instance.currentUser
            ?.uid, // Include current user's UID if authenticated
        'authorizationCode':
            "appleCredential.authorizationCode", // Replace with actual authorization code
      };

      // Send POST request using Dio
      final response = await dio.post(
        url,
        data: requestBody,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            // Add any additional headers as needed
          },
        ),
      );

      // Handle Cloud Function response
      if (response.statusCode == 200) {
        print("Music User Token obtained successfully: ${response.data}");
        // Handle successful response
      } else {
        print(
            "Error obtaining Music User Token: ${response.statusCode} - ${response.data}");
        // Handle error response
      }
    } catch (e) {
      print("Error calling Cloud Function: $e");
      // Handle Dio errors or any other exceptions
    }
  }
}
