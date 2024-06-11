import 'package:bmp_music/features/song/notifiers/song_notifier.dart';
import 'package:bmp_music/features/song/ui/components/songs_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../features/bpm/ui/components/bpm_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const BPMCard(),
        SongsList(songs: context.watch<SongNotifier>().songs),
      ],
    );
  }
}
