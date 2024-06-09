import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveShuffle(bool shuffle) async {
  // Obtain an instance of SharedPreferences
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  await sharedPreferences.setBool('shuffle', shuffle);
}
