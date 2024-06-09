import 'package:audio_service/audio_service.dart';

import '../models/song_model.dart';

MediaItem songToMediaItem(Song song) => MediaItem(
      id: song.previewUrl,
      album: song.albumName,
      title: song.name,
      artist: song.artistName,
      displayTitle: song.artworkUrl,
      artUri: Uri.parse(song.artworkUrl),
      displayDescription: song.id,
    );
