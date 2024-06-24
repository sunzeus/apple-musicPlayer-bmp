import 'package:audio_service/audio_service.dart';
import 'package:bmp_music/features/album/notifiers/album_notifier.dart';
import 'package:bmp_music/features/auth/screens/apple_auth_screen.dart';
import 'package:bmp_music/features/auth/screens/apple_music_auth_screen.dart';
import 'package:bmp_music/features/song/notifiers/song_notifier.dart';
import 'package:bmp_music/features/bpm/notifiers/bpm_notifier.dart';
import 'package:bmp_music/shared/ui/screens/main_screen.dart';
import 'package:bmp_music/utils/color_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

import 'features/song/services/song_handler.dart';
import 'firebase_options.dart';

SongHandler _songHandler = SongHandler();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  _songHandler = await AudioService.init(
    builder: () => SongHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.musicpacemaker.app',
      androidNotificationChannelName: 'Music Pacemaker',
      androidNotificationOngoing: true,
      androidShowNotificationBadge: true,
    ),
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SongNotifier()..assignHandler(_songHandler),
        ),
        ChangeNotifierProvider(create: (_) => AlbumNotifier()),
        ChangeNotifierProvider(create: (_) => BPMNotifier()..init()),
      ],
      child: GetMaterialApp(
        theme: ThemeData(
          colorSchemeSeed: ColorUtils.darkRed,
          useMaterial3: true,
          brightness: Brightness.light,
        ),
        home: const CheckAuthStatus(),
      ),
    );
  }
}

class CheckAuthStatus extends StatelessWidget {
  const CheckAuthStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        User? user = snapshot.data;
        if (user == null) {
          return const AppleAuthScreen();
        } else {
          return const AppleMusicAuthPage();
        }
      },
    );
  }
}
