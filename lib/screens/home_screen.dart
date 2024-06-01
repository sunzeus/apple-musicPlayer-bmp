import 'package:bmp_music/components/bpm_card.dart';
import 'package:bmp_music/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: ColorUtils.systemNavigationBarColorStyle(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("BPM Music"),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search_rounded),
            ),
          ],
        ),
        body: CustomScrollView(
          slivers: [
            BPMCard(),
          ],
        ),
      ),
    );
  }
}
