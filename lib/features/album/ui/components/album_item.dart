import 'package:bmp_music/features/album/models/album_model.dart';
import 'package:flutter/material.dart';

import '../../../../shared/ui/components/artwork_view.dart';

class AlbumItem extends StatelessWidget {
  final Album album;
  const AlbumItem({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO : Navigate to album page
      },
      child: Column(
        children: [
          Expanded(
            child: ArtWorkView(
              url: album.artworkUrl,
              height: double.infinity,
              width: double.infinity,
            ),
          ),
          ListTile(
            title: Text(
              album.name,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              album.artistName,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
