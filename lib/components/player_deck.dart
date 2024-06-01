import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class PlayerDeck extends StatelessWidget {
  const PlayerDeck({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
            image: const AssetImage("assets/image/image2.jpg"),
          ),
        ),
      ),
      title: const Text(
        "Rizky Ayuba",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: const Text("Kimi No Toriko"),
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
    );
  }
}
