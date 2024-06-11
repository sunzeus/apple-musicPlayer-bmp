import 'package:bmp_music/features/album/ui/components/albums_grid_view.dart';
import 'package:bmp_music/features/album/ui/components/albums_list_view.dart';
import 'package:flutter/material.dart';

import '../components/category_card.dart';
import '../utils/color_utils.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  // final List<CategoryModel> _categories = [
  //   CategoryModel(
  //     title: "アルバム",
  //     icon: Icons.album_rounded,
  //   ),
  //   CategoryModel(
  //     title: "プレイリスト",
  //     icon: Icons.playlist_play_rounded,
  //   ),
  //   CategoryModel(
  //     title: "お気に入り",
  //     icon: Icons.favorite_rounded,
  //   ),
  // ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildAlbums(),
      ],
    );

    // return Scaffold(
    //   // body: Column(
    //   //   children: [
    //   //     _buildCategories(),
    //   //     Flexible(
    //   //       child: activeCategory == "曲"
    //   //           ? const SongsCategoryItems()
    //   //           : activeCategory == "アルバム"
    //   //               ? const AlbumsCategoryItems()
    //   //               : activeCategory == "プレイリスト"
    //   //                   ? const PlaylistsCategoryItems()
    //   //                   : const FavoriteCategoryItems(),
    //   //     ),
    //   //   ],
    //   // ),
    // );
  }

  Widget _buildAlbums() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text("アルバム"),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          width: double.infinity,
          child: const AlbumsListView(),
        ),
      ],
    );
  }
}
