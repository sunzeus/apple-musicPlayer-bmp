import 'package:shared_preferences/shared_preferences.dart';

Future<bool> readShuffle() async {
  // Obtain an instance of SharedPreference
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  final result = sharedPreferences.getBool('shuffle');
  return result ?? false;
}
