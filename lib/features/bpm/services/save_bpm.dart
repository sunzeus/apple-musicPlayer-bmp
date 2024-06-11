import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveBPM(int bpm) async {
  // Obtain an instance of SharedPreferences
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  // Save the curent bpm to SharedPreference
  await sharedPreferences.setInt('bpm', bpm);
}
