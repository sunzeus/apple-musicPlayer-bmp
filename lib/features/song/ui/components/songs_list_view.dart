import 'package:audio_service/audio_service.dart';
import 'package:bmp_music/features/song/notifiers/song_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/song_model.dart';
import 'song_item.dart';

class SongsList extends StatelessWidget {
  final List<Song> songs;
  const SongsList({super.key, required this.songs});

  @override
  Widget build(BuildContext context) {
    final songNotifier = context.watch<SongNotifier>();

    bool isLoading = songNotifier.loading;

    return isLoading
        ? const Expanded(
            child: Center(
              child: CircularProgressIndicator(
                strokeCap: StrokeCap.round,
              ),
            ),
          )
        : songs.isEmpty
            ? const Center(
                child: Text("No songs"),
              )
            : ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: songs.length,
                itemBuilder: (context, index) {
                  final song = songs[index];

                  // Build the SongItem based on the playback state
                  return StreamBuilder<MediaItem?>(
                    stream: songNotifier.songHandler.mediaItem.stream,
                    builder: (context, snapshot) {
                      MediaItem? playingSong = snapshot.data;

                      // Check if the current item is the last one
                      return SongItem(
                        isPlaying: song.id == playingSong?.displayDescription,
                        title: song.name,
                        artist: song.artistName,
                        onSongTap: () async {
                          int index = songs.indexOf(song);
                          await songNotifier.songHandler.skipToQueueItem(index);
                        },
                        url: song.artworkUrl,
                      );
                    },
                  );
                },
              );
  }
}
