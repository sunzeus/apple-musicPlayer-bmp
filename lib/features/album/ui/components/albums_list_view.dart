import 'package:bmp_music/features/album/notifiers/album_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'album_item.dart';

class AlbumsListView extends StatelessWidget {
  const AlbumsListView({super.key});

  @override
  Widget build(BuildContext context) {
    AlbumNotifier albumNotifier = context.watch<AlbumNotifier>();
    final albums = albumNotifier.albums;

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemCount: albums.length,
      itemBuilder: (context, index) {
        final album = albums[index];

        return AlbumItem(album: album);
      },
    );
  }
}
