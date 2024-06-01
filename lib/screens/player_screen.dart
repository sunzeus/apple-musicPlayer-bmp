import 'package:bmp_music/components/player_progress.dart';
import 'package:bmp_music/models/item_model.dart';
import 'package:bmp_music/notifiers/bpm_notifier.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

import '../utils/color_utils.dart';
import 'bpm_settings_screen.dart';

class PlayerScreen extends StatefulWidget {
  final Item item;
  const PlayerScreen({super.key, required this.item});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24.0),
                    child: FadeInImage(
                      height: MediaQuery.of(context).size.width * 0.75,
                      placeholder: MemoryImage(kTransparentImage),
                      fit: BoxFit.cover,
                      image:  AssetImage(widget.item.image),
                    ),
                  ),
                  ListTile(
                    subtitle:  Text(
                      widget.item.artist,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    title:  Text(widget.item.title),
                    trailing: IconButton.filledTonal(
                      onPressed: () {},
                      icon: const Icon(Icons.more_horiz_rounded),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => Get.to(
                      () => const BPMSettingsScreen(),
                      transition: Transition.rightToLeft,
                      duration: const Duration(milliseconds: 700),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: ColorUtils.lightRed,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            "BPM",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: ColorUtils.lightGrey,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          context.watch<BPMNotifier>().value.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "消費 ：",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: ColorUtils.lightBlack,
                      ),
                    ),
                    const Text(
                      "200kcal/時間",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 36.0,
              right: 36.0,
              top: 36.0,
            ),
            child: Column(
              children: [
                const PlayerProgress(),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.skip_previous_rounded,
                        size: 40,
                      ),
                    ),
                    const SizedBox(width: 20),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.pause_rounded,
                        color: ColorUtils.darkRed,
                        size: 60,
                      ),
                    ),
                    const SizedBox(width: 20),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.skip_next_rounded,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite_border_rounded,
                ),
              ),
              const SizedBox(width: 30),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.list_rounded,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
