import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'song_model.dart';

class Playlist {
  final String id;
  final String name;
  final String curatorName;
  final String artworkUrl;
  final List<Song> songs;

  Playlist({
    required this.id,
    required this.name,
    required this.curatorName,
    required this.artworkUrl,
    required this.songs,
  });

  Playlist copyWith({
    String? id,
    String? name,
    String? curatorName,
    String? artworkUrl,
    List<Song>? songs,
  }) {
    return Playlist(
      id: id ?? this.id,
      name: name ?? this.name,
      curatorName: curatorName ?? this.curatorName,
      artworkUrl: artworkUrl ?? this.artworkUrl,
      songs: songs ?? this.songs,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'curatorName': curatorName,
      'artworkUrl': artworkUrl,
      'songs': songs.map((x) => x.toMap()).toList(),
    };
  }

  factory Playlist.fromMap(Map<String, dynamic> map) {
    return Playlist(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      curatorName: map['curatorName'] ?? '',
      artworkUrl: map['artworkUrl'] ?? '',
      songs: List<Song>.from(map['songs']?.map((x) => Song.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Playlist.fromJson(String source) =>
      Playlist.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Playlist(id: $id, name: $name, curatorName: $curatorName, artworkUrl: $artworkUrl, songs: $songs)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Playlist &&
        other.id == id &&
        other.name == name &&
        other.curatorName == curatorName &&
        other.artworkUrl == artworkUrl &&
        listEquals(other.songs, songs);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        curatorName.hashCode ^
        artworkUrl.hashCode ^
        songs.hashCode;
  }
}
