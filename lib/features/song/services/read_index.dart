import 'package:shared_preferences/shared_preferences.dart';

Future<int?> readIndex() async {
  // Obtain an instance of SharedPreference
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  // Retrieve the last saved index from SharedPreferences
  return sharedPreferences.getInt('index');
}
