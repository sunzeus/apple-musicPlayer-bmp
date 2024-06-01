import 'package:bmp_music/notifiers/bpm_notifier.dart';
import 'package:bmp_music/notifiers/category_notifier.dart';
import 'package:bmp_music/screens/home_screen.dart';
import 'package:bmp_music/screens/player_screen.dart';
import 'package:bmp_music/screens/profile_screen.dart';
import 'package:bmp_music/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BPMNotifier()),
        ChangeNotifierProvider(create: (_) => CategoryNotifier()),
      ],
      child: GetMaterialApp(
        theme: ThemeData(
          colorSchemeSeed: ColorUtils.darkRed,
          useMaterial3: true,
          scaffoldBackgroundColor:
              Colors.white, // Set scaffold background color
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white, // Set app bar background color
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
