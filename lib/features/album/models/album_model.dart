import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../song/models/song_model.dart';

class Album {
  final String id;
  final String name;
  final String artistName;
  final String artworkUrl;
  final List<Song> songs;

  Album({
    required this.id,
    required this.name,
    required this.artistName,
    required this.artworkUrl,
    required this.songs,
  });

 

  Album copyWith({
    String? id,
    String? name,
    String? artistName,
    String? artworkUrl,
    List<Song>? songs,
  }) {
    return Album(
      id: id ?? this.id,
      name: name ?? this.name,
      artistName: artistName ?? this.artistName,
      artworkUrl: artworkUrl ?? this.artworkUrl,
      songs: songs ?? this.songs,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'artistName': artistName,
      'artworkUrl': artworkUrl,
      'songs': songs.map((x) => x.toMap()).toList(),
    };
  }

  factory Album.fromMap(Map<String, dynamic> map) {
    return Album(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      artistName: map['artistName'] ?? '',
      artworkUrl: map['artworkUrl'] ?? '',
      songs: List<Song>.from(map['songs']?.map((x) => Song.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Album.fromJson(String source) => Album.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Album(id: $id, name: $name, artistName: $artistName, artworkUrl: $artworkUrl, songs: $songs)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Album &&
      other.id == id &&
      other.name == name &&
      other.artistName == artistName &&
      other.artworkUrl == artworkUrl &&
      listEquals(other.songs, songs);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      artistName.hashCode ^
      artworkUrl.hashCode ^
      songs.hashCode;
  }
}
