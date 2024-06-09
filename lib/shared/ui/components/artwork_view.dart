import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ArtWorkView extends StatelessWidget {
  final String? url;
  final double height;
  final double width;
  const ArtWorkView({
    super.key,
    required this.url,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.5),
      ),
      child: url == null
          ? const SizedBox.shrink()
          : ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: FadeInImage(
                height: height,
                width: width,
                image: NetworkImage(url!),
                placeholder: MemoryImage(kTransparentImage),
                fadeInDuration: const Duration(milliseconds: 700),
                fit: BoxFit.cover,
              ),
            ),
    );
  }
}
