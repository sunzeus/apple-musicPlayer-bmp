import 'package:audio_service/audio_service.dart';
import 'package:bmp_music/shared/ui/components/artwork_view.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../notifiers/song_notifier.dart';
import 'play_pause_button.dart';

class PlayerDeck extends StatelessWidget {
  const PlayerDeck({super.key});

  @override
  Widget build(BuildContext context) {
    // Use StreamBuilder to reactively build UI based on changes to the mediaItem stream
    return StreamBuilder<MediaItem?>(
      stream: context.watch<SongNotifier>().songHandler.mediaItem.stream,
      builder: (context, snapshot) {
        MediaItem? playingSong = snapshot.data;
        // If there's no playing song, return an empty widget
        return playingSong == null
            ? const SizedBox.shrink()
            : _buildCard(context, playingSong);
      },
    );
  }

  // Build the main card widget
  Widget _buildCard(BuildContext context, MediaItem playingSong) {
    String artist = playingSong.artist ?? "";
    String name = playingSong.title;
    String? url = playingSong.displayTitle;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: ListTile(
          onTap: () {
            // TODO : Navigate to Player Screen
          },
          leading: ArtWorkView(
            url: url,
            height: 50,
            width: 50,
          ),
          title: Text(name),
          subtitle: Text(artist),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const PlayPauseButton(),
              IconButton.filledTonal(
                onPressed: () => context.read<SongNotifier>().skipToNext(),
                icon: const Icon(Icons.skip_next_rounded),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
