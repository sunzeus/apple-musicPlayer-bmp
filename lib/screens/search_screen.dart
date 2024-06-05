import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _textEditingController,
          autofocus: false,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Search",
          ),
          onChanged: (value) {
            // Clear the result list and perform a new search when the input changes
            setState(() {});
          },
        ),
        actions: [
          // Display a close button if the search input is not empty
          if (_textEditingController.text.trim().isNotEmpty)
            IconButton(
              onPressed: () {
                // Clear the search input and result list
                setState(() {
                  _textEditingController.clear();
                });
              },
              icon: const Icon(Icons.close),
            ),
        ],
      ),
    );
  }
}
