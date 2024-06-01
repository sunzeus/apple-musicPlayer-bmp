import 'package:bmp_music/notifiers/category_notifier.dart';
import 'package:bmp_music/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  const CategoryCard({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    bool isActive = context.watch<CategoryNotifier>().activeCategory == title;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            context.read<CategoryNotifier>().updateCategory(title);
          },
          child: Container(
            decoration: BoxDecoration(
              color: isActive ? ColorUtils.lightRed : ColorUtils.lightGrey,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: isActive ? Colors.white : null,
                    ),
                  ),
                  Icon(
                    icon,
                    color: isActive ? Colors.white : null,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
