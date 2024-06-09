import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveIndex(int index) async {
  // Obtain an instance of SharedPreferences
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  // Save the curent index to SharedPreference
  await sharedPreferences.setInt('index', index);
}
