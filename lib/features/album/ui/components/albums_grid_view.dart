import 'package:flutter/material.dart';

import '../../models/album_model.dart';
import 'album_item.dart';

class AlbumsGridView extends StatelessWidget {
  final List<Album> albums;
  const AlbumsGridView({super.key, required this.albums});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: albums.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          childAspectRatio: 0.85,
        ),
        itemBuilder: (context, index) {
          final album = albums[index];

          return AlbumItem(album: album);
        },
      ),
    );
  }
}
