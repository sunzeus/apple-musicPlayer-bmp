import 'package:flutter/material.dart';

import '../../utils/color_utils.dart';

class PlaylistsCategoryItems extends StatelessWidget {
  const PlaylistsCategoryItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: albumsItems.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.85,
        ),
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 125,
                width: 125,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(
                      albumsItems[index].image,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      albumsItems[index].title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      "Songs ${albumsItems[index].songCount}",
                      style: TextStyle(
                        fontSize: 12,
                        color: ColorUtils.lightBlack,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class PlaylistItem {
  final String image;
  final String title;
  final int songCount;
  PlaylistItem({
    required this.image,
    required this.title,
    required this.songCount,
  });
}

List<PlaylistItem> albumsItems = [
  PlaylistItem(
    image: "assets/image/Dx7egGAVAAA0_PK-1024x636.jpg",
    title: "ラブソング",
    songCount: 14,
  ),
  PlaylistItem(
    image: "assets/image/37835610345_c86accdcee_b.jpg",
    title: "ゲームモード",
    songCount: 3,
  ),
];
