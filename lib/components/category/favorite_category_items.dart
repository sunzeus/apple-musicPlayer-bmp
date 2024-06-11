// import 'package:bmp_music/utils/color_utils.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../database/items_db.dart';
// import '../../features/song/ui/screens/player_screen.dart';

// class FavoriteCategoryItems extends StatelessWidget {
//   const FavoriteCategoryItems({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: songItems.length,
//       physics: const BouncingScrollPhysics(),
//       itemBuilder: (context, index) {
//         return ListTile(
//           onTap: () => Get.to(
//             () => PlayerScreen(item: songItems[index]),
//             transition: Transition.downToUp,
//             duration: const Duration(milliseconds: 700),
//           ),
//           leading: ClipRRect(
//             borderRadius: BorderRadius.circular(8.0),
//             child: SizedBox(
//               height: 45,
//               width: 45,
//               child: Image.asset(
//                 songItems[index].image,
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           title: Text(songItems[index].artist),
//           subtitle: Text(songItems[index].title),
//           trailing: IconButton(
//             onPressed: () {},
//             icon: Icon(
//               Icons.favorite_rounded,
//               color: ColorUtils.darkRed,
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
