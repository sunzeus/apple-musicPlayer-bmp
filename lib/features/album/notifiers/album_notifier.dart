import 'package:bmp_music/features/album/services/fetch_albums.dart';
import 'package:flutter/material.dart';

import '../models/album_model.dart';

class AlbumNotifier extends ChangeNotifier {
  bool _loading = true;

  bool get loading => _loading;

  List<Album> _albums = [];

  List<Album> get albums => _albums;

  Future<void> loadAlbums() async {
    _albums = await fetchAlbums();
    _loading = false;
    notifyListeners();
  }
}
