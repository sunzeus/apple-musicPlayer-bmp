import 'package:audio_service/audio_service.dart';
import 'package:bmp_music/components/player_progress.dart';
import 'package:bmp_music/features/bpm/notifiers/bpm_notifier.dart';
import 'package:bmp_music/features/song/ui/components/play_pause_button.dart';
import 'package:bmp_music/shared/ui/components/artwork_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

import '../../../../utils/color_utils.dart';
import '../../../bpm/ui/screens/bpm_settings_screen.dart';
import '../../notifiers/song_notifier.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  @override
  Widget build(BuildContext context) {
    final songNotifier = context.watch<SongNotifier>();

    LoopMode loopMode = songNotifier.loopMode;

    return StreamBuilder<MediaItem?>(
      stream: songNotifier.songHandler.mediaItem.stream,
      builder: (context, snapshot) {
        MediaItem? playingSong = snapshot.data;

        String artworkUrl = playingSong?.displayTitle ?? "";

        String artist = playingSong?.artist ?? "";

        String name = playingSong?.title ?? "";

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
                      ArtWorkView(
                        url: artworkUrl,
                        height: MediaQuery.of(context).size.width * 0.8,
                        width: MediaQuery.of(context).size.width * 0.8,
                      ),
                      ListTile(
                        subtitle: Text(
                          artist,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        title: Text(name),
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                            songNotifier.updateShuffle();
                          },
                          icon: Icon(
                            Icons.shuffle_rounded,
                            color: songNotifier.shuffle == false
                                ? null
                                : Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            songNotifier.skipToPrevious();
                          },
                          icon: const Icon(
                            Icons.skip_previous_rounded,
                            size: 40,
                          ),
                        ),
                        const SizedBox(width: 20),
                        const PlayPauseButton(size: 45),
                        const SizedBox(width: 20),
                        IconButton(
                          onPressed: () {
                            songNotifier.skipToNext();
                          },
                          icon: const Icon(
                            Icons.skip_next_rounded,
                            size: 40,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            if (loopMode == LoopMode.off) {
                              Provider.of<SongNotifier>(context, listen: false)
                                  .updateLoopMode(LoopMode.one);
                            } else {
                              Provider.of<SongNotifier>(context, listen: false)
                                  .updateLoopMode(LoopMode.off);
                            }
                          },
                          icon: Icon(
                            Icons.loop_rounded,
                            color: loopMode == LoopMode.off
                                ? null
                                : Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Row(
              //   mainAxisSize: MainAxisSize.min,
              //   children: [
              //     IconButton(
              //       onPressed: () {},
              //       icon: const Icon(
              //         Icons.favorite_border_rounded,
              //       ),
              //     ),
              //     const SizedBox(width: 30),
              //     IconButton(
              //       onPressed: () {},
              //       icon: const Icon(
              //         Icons.list_rounded,
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        );
      },
    );
  }
}
