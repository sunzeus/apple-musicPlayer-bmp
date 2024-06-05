import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ColorUtils {
  static Color darkRed = const Color(0xFFFC3C44);
  static Color lightRed = const Color(0xFFF94C57);
  static Color darkGrey = const Color(0xFFC2CAD7);
  static Color lightGrey = const Color(0xFFF5F5F5);
  static Color lightBlack = Colors.black.withOpacity(0.65);

  static SystemUiOverlayStyle systemNavigationBarColorStyle(
          BuildContext context) =>
      SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        systemNavigationBarColor: Colors.white,
        statusBarIconBrightness: Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark,
        systemNavigationBarIconBrightness:
            Theme.of(context).brightness == Brightness.dark
                ? Brightness.light
                : Brightness.dark,
      );

  static Color systemNavigationBarColor(BuildContext context) =>
      ElevationOverlay.applySurfaceTint(
        Theme.of(context).colorScheme.surface,
        Theme.of(context).colorScheme.surfaceTint,
        2,
      );
}
