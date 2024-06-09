import 'dart:convert';

import 'package:bmp_music/components/bpm_card.dart';

import 'package:bmp_music/components/category/favorite_category_items.dart';
import 'package:bmp_music/components/category/playlists_category_items.dart';
import 'package:bmp_music/components/category/songs_category_items.dart';
import 'package:bmp_music/components/category_card.dart';
import 'package:bmp_music/components/player_deck.dart';
import 'package:bmp_music/notifiers/category_notifier.dart';
import 'package:bmp_music/screens/profile_screen.dart';
import 'package:bmp_music/utils/color_utils.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../models/category_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<CategoryModel> _categories = [
    CategoryModel(
      title: "曲",
      icon: Icons.music_note_rounded,
    ),
    CategoryModel(
      title: "アルバム",
      icon: Icons.album_rounded,
    ),
    CategoryModel(
      title: "プレイリスト",
      icon: Icons.playlist_play_rounded,
    ),
    CategoryModel(
      title: "お気に入り",
      icon: Icons.favorite_rounded,
    ),
  ];

  Future<void> _getMusicUserToken() async {
    try {
      HttpsCallable callable =
          FirebaseFunctions.instance.httpsCallable('getDeveloperToken');
      dynamic response = await callable.call();
      // String musicUserToken = response.data['musicUserToken'];
      debugPrint("RESPONSE : ${response}");
      // print('Music User Token: $musicUserToken');
    } catch (e) {
      print('Failed to get Music User Token: $e');
    }
  }

  Future<void> getDeveloperToken() async {
    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(
      'getDeveloperToken',
      options: HttpsCallableOptions(
        timeout: const Duration(seconds: 5),
      ),
    );
    HttpsCallableResult response = await callable();
    // final response = await http.get(Uri.parse(
    //     'https://us-central1-music-app-9ee48.cloudfunctions.net/getDeveloperToken'));

    debugPrint("RESPONSE : ${response.data}");

    // if (response.statusCode == 200) {
    //   // Parse the JSON response
    //   final json = jsonDecode(response.body);
    //   final token = json['token'];
    //   return token;
    // } else {
    //   // Handle errors
    //   throw Exception('Failed to load developer token');
    // }
  }

  @override
  Widget build(BuildContext context) {
    final activeCategory = context.watch<CategoryNotifier>().activeCategory;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: ColorUtils.systemNavigationBarColorStyle(context),
      child: Scaffold(
        appBar: AppBar(
          leading: Center(
            child: GestureDetector(
              onTap: () async {
                final result = await getDeveloperToken();
                
              },
              // onTap: () => Get.to(
              //   () => const ProfileScreen(),
              //   transition: Transition.leftToRight,
              //   duration: const Duration(milliseconds: 700),
              // ),
              child: const CircleAvatar(
                backgroundImage: AssetImage("assets/image/image3.jpeg"),
              ),
            ),
          ),
          title: const Text("音楽ペースメーカー"),
        ),
        // body: Column(
        //   children: [
        //     Expanded(
        //       child: Column(
        //         mainAxisSize: MainAxisSize.min,
        //         children: [
        //           const BPMCard(),
        //           _buildCategories(),
        //           Flexible(
        //             child: activeCategory == "曲"
        //                 ? const SongsCategoryItems()
        //                 : activeCategory == "アルバム"
        //                     ? const AlbumsCategoryItems()
        //                     : activeCategory == "プレイリスト"
        //                         ? const PlaylistsCategoryItems()
        //                         : const FavoriteCategoryItems(),
        //           ),
        //         ],
        //       ),
        //     ),
        //     const PlayerDeck(),
        //   ],
        // ),
      ),
    );
  }

  Widget _buildCategories() => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                left: 16.0,
                right: 16.0,
                bottom: 16.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "図書館",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ColorUtils.lightBlack,
                    ),
                  ),
                  Icon(
                    Icons.filter_list_rounded,
                    color: ColorUtils.lightRed,
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CategoryCard(
                        title: _categories[0].title,
                        icon: _categories[0].icon,
                      ),
                      CategoryCard(
                        title: _categories[1].title,
                        icon: _categories[1].icon,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CategoryCard(
                        title: _categories[2].title,
                        icon: _categories[2].icon,
                      ),
                      CategoryCard(
                        title: _categories[3].title,
                        icon: _categories[3].icon,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      );
}
