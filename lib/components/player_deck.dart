import 'dart:math';

import 'package:bmp_music/database/items_db.dart';
import 'package:bmp_music/screens/player_screen.dart';
import 'package:bmp_music/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';

class PlayerDeck extends StatelessWidget {
  const PlayerDeck({super.key});

  @override
  Widget build(BuildContext context) {
    Random random = Random();
    int index = random.nextInt(songItems.length);
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: ColorUtils.darkGrey,
          ),
        ),
      ),
      child: ListTile(
        onTap: () => Get.to(
          () => PlayerScreen(item: songItems[index]),
          transition: Transition.downToUp,
          duration: const Duration(milliseconds: 700),
        ),
        contentPadding: const EdgeInsets.only(
          left: 16.0,
          right: 8.0,
        ),
        leading: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              fit: BoxFit.cover,
              image: AssetImage(songItems[index].image),
            ),
          ),
        ),
        title: Text(
          songItems[index].artist,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(songItems[index].title),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton.filledTonal(
              onPressed: () {},
              icon: const Icon(
                Icons.play_arrow_rounded,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton.filledTonal(
                onPressed: () {},
                icon: const Icon(
                  Icons.skip_next_rounded,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
