import 'package:bmp_music/features/song/notifiers/song_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../notifiers/bpm_notifier.dart';
import '../../../../utils/color_utils.dart';

class BPMChangeCard extends StatelessWidget {
  const BPMChangeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: ColorUtils.lightGrey,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: Text(
                  "BPM",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: ColorUtils.lightBlack,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                context.watch<BPMNotifier>().value.toString(),
                style: const TextStyle(
                  fontSize: 96,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Slider(
                  min: 0.5,
                  max: 2.0,
                  thumbColor: ColorUtils.darkRed,
                  activeColor: ColorUtils.lightRed,
                  value: (context.watch<BPMNotifier>().value / 100),
                  onChanged: (c) {
                    context.read<BPMNotifier>().updateValue((c * 100).toInt());
                    double speed = c;
                    context.read<SongNotifier>().songHandler.setSpeed(speed);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
