import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<LoopMode> readLoopMode() async {
  // Obtain an instance of SharedPreference
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  final savedLoop = sharedPreferences.getString('loopMode');

  LoopMode loopMode = savedLoop == null
      ? LoopMode.off
      : savedLoop == "one"
          ? LoopMode.one
          : LoopMode.off;
  return loopMode;
}
