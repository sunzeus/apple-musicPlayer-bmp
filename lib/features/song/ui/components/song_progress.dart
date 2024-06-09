import 'package:audio_service/audio_service.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../notifiers/song_notifier.dart';

class SongProgress extends StatelessWidget {
  final Duration totalDuration;

  const SongProgress({
    super.key,
    required this.totalDuration,
  });

  @override
  Widget build(BuildContext context) {
    SongNotifier songNotifier = context.watch<SongNotifier>();
    final songHandler = songNotifier.songHandler;
    return StreamBuilder<Duration>(
      stream: AudioService.position,
      builder: (context, positionSnapshot) {
        // Retrieve the current position from the stream
        Duration? position = positionSnapshot.data;

        // Display the ProgressBar widget
        return ProgressBar(
          // Set the progress to the current position or zero if null
          progress: position ?? Duration.zero,
          // Set the total duration of the song
          total: totalDuration,
          // Callback for seeking when the user interacts with the progress bar
          onSeek: (position) {
            songHandler.seek(position);
          },
          // Customize the appearance of the progress bar
          barHeight: 5,
          thumbRadius: 2.5,
          thumbGlowRadius: 5,
          timeLabelLocation: TimeLabelLocation.below,
          timeLabelPadding: 10,
        );
      },
    );
  }
}
