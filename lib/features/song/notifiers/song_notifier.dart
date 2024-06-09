import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../models/song_model.dart';
import '../services/fetch_songs.dart';
import '../services/read_loop_mode.dart';
import '../services/read_shuffle.dart';
import '../services/save_loop_mode.dart';
import '../services/save_shuffle.dart';
import '../services/song_handler.dart';
import '../services/song_to_media_item.dart';

class SongNotifier extends ChangeNotifier {
  bool loading = true;
  late SongHandler _songHandler;

  SongHandler get songHandler => _songHandler;

  void assignHandler(SongHandler handler) {
    _songHandler = handler;
    notifyListeners();
  }

  void skipToNext() {
    _songHandler.skipToNext();
    notifyListeners();
  }

  void skipToPrevious() {
    _songHandler.skipToPrevious();
    notifyListeners();
  }

  LoopMode _loopMode = LoopMode.off;
  LoopMode get loopMode => _loopMode;

  bool _shuffle = false;
  bool get shuffle => _shuffle;

  void updateLoopMode(LoopMode newLoopMode) {
    _loopMode = newLoopMode;
    saveLoopMode(newLoopMode);
    _songHandler.toggleLoopMode(newLoopMode);
    notifyListeners();
  }

  void updateShuffle() {
    _shuffle = !shuffle;
    saveShuffle(shuffle);
    if (shuffle) {
      _songHandler.shuffleQueue();
    } else {
      _songHandler.unShuffleQueue();
    }
    notifyListeners();
  }

  List<Song> _songs = [];

  List<Song> get songs => _songs;

  Future<void> loadSongs() async {
    _loopMode = await readLoopMode();
    _shuffle = await readShuffle();
    final results = await fetchSongs();
    _songs = results;
    await _songHandler.initSongs(
        songs: results.map((s) => songToMediaItem(s)).toList());
    _songHandler.toggleLoopMode(loopMode);
    if (shuffle) {
      _songHandler.shuffleQueue();
    }
    loading = false;
    notifyListeners();
  }
}
