import 'package:bmp_music/utils/color_utils.dart';
import 'package:flutter/material.dart';

class AlbumsCategoryItems extends StatelessWidget {
  const AlbumsCategoryItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: albumsItems.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          childAspectRatio: 0.85,
        ),
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Image.asset(
                  albumsItems[index].image,
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                    albumsItems[index].artist,
                    style: TextStyle(
                      fontSize: 12,
                      color: ColorUtils.lightBlack,
                    ),
                  ),
                  Text(
                    "Songs ${albumsItems[index].songCount}",
                    style: TextStyle(
                      fontSize: 12,
                      color: ColorUtils.darkRed,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class AlbumItem {
  final String image;
  final String artist;
  final String title;
  final int songCount;
  AlbumItem({
    required this.image,
    required this.artist,
    required this.title,
    required this.songCount,
  });
}

List<AlbumItem> albumsItems = [
  AlbumItem(
    image: "assets/image/Sunshower+Taeko.jpeg",
    artist: "Taeko Ohnuki",
    title: "Sunshower (1977)",
    songCount: 5,
  ),
  AlbumItem(
    image: "assets/image/R-6016245-1480909922-6423.jpeg.jpg",
    artist: "Junko Yagami",
    title: "Moon",
    songCount: 12,
  ),
  AlbumItem(
    image: "assets/image/tomoko.jpg",
    artist: "Tomoko Aran",
    title: "Fuyu Kukan",
    songCount: 7,
  ),
];
