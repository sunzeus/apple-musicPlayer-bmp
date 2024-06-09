import 'package:bmp_music/shared/ui/components/artwork_view.dart';
import 'package:flutter/material.dart';

import '../../../../shared/utils/text_utils.dart';

class SongItem extends StatelessWidget {
  final String? searchedWord;
  final bool isPlaying;
  final String? url;
  final String title;
  final String? artist;
  final VoidCallback onSongTap;

  // Constructor for the SongItem class
  const SongItem({
    super.key,
    required this.isPlaying,
    required this.title,
    required this.artist,
    required this.onSongTap,
    this.searchedWord,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: ListTile(
        contentPadding: const EdgeInsets.only(
          left: 14.0,
        ),
        selected: isPlaying,
        selectedTileColor:
            Theme.of(context).colorScheme.primaryContainer.withOpacity(0.25),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        // Handle tap on the ListTile
        onTap: () => onSongTap(),
        // Build leading widget (artwork)
        leading: ArtWorkView(url: url, height: 45, width: 45),
        // Build title and subtitle widgets
        title: _buildTitle(context),
        subtitle: _buildSubtitle(context),
      ),
    );
  }

  // Build the title widget with optional search word formatting
  Widget _buildTitle(BuildContext context) {
    return searchedWord != null
        ? TextUtils.search(
            corpus: title,
            searchedWord: searchedWord!,
            context: context,
          )
        : Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
  }

  // Build the subtitle widget with optional search word formatting
  Text? _buildSubtitle(BuildContext context) {
    return artist == null
        ? null
        : searchedWord != null
            ? TextUtils.search(
                corpus: artist!,
                searchedWord: searchedWord!,
                context: context,
              )
            : Text(
                artist!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              );
  }
}
