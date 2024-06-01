import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:bmp_music/utils/color_utils.dart';
import 'package:flutter/material.dart';

class PlayerProgress extends StatefulWidget {
  const PlayerProgress({super.key});

  @override
  State<PlayerProgress> createState() => _PlayerProgressState();
}

class _PlayerProgressState extends State<PlayerProgress> {
  Duration _progress = const Duration(minutes: 1);
  @override
  Widget build(BuildContext context) {
    return ProgressBar(
      // Set the progress to the current position or zero if null
      progress: _progress,
      // Set the total duration of the song
      total: const Duration(minutes: 3),
      // Callback for seeking when the user interacts with the progress bar
      onSeek: (position) {
        setState(() {
          _progress = position;
        });
      },
      thumbColor: ColorUtils.darkRed,
      progressBarColor: ColorUtils.lightRed,
    );
  }
}
