import 'package:bmp_music/notifiers/bpm_notifier.dart';
import 'package:bmp_music/screens/home_screen.dart';
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
      ],
      child: const GetMaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}
