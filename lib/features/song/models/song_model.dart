import 'dart:convert';

class Song {
  final String id;
  final String name;
  final String artistName;
  final String albumName;
  final String artworkUrl;
  final String previewUrl;

  Song({
    required this.id,
    required this.name,
    required this.artistName,
    required this.albumName,
    required this.artworkUrl,
    required this.previewUrl,
  });

  Song copyWith({
    String? id,
    String? name,
    String? artistName,
    String? albumName,
    String? artworkUrl,
    String? previewUrl,
  }) {
    return Song(
      id: id ?? this.id,
      name: name ?? this.name,
      artistName: artistName ?? this.artistName,
      albumName: albumName ?? this.albumName,
      artworkUrl: artworkUrl ?? this.artworkUrl,
      previewUrl: previewUrl ?? this.previewUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'artistName': artistName,
      'albumName': albumName,
      'artworkUrl': artworkUrl,
      'previewUrl': previewUrl,
    };
  }

  factory Song.fromMap(Map<String, dynamic> map) {
    return Song(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      artistName: map['artistName'] ?? '',
      albumName: map['albumName'] ?? '',
      artworkUrl: map['artworkUrl'] ?? '',
      previewUrl: map['previewUrl'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Song.fromJson(String source) => Song.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Song(id: $id, name: $name, artistName: $artistName, albumName: $albumName, artworkUrl: $artworkUrl, previewUrl: $previewUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Song &&
        other.id == id &&
        other.name == name &&
        other.artistName == artistName &&
        other.albumName == albumName &&
        other.artworkUrl == artworkUrl &&
        other.previewUrl == previewUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        artistName.hashCode ^
        albumName.hashCode ^
        artworkUrl.hashCode ^
        previewUrl.hashCode;
  }
}
