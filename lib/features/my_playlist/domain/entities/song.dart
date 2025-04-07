import 'dart:convert';

class Song {
  final String imageUrl;
  final String name;
  final String albumName;
  final String mp3Url;

  Song({
    required this.imageUrl,
    required this.name,
    required this.albumName,
    required this.mp3Url,
  });

  Song copyWith({
    String? imageUrl,
    String? name,
    String? albumName,
    String? mp3Url,
  }) {
    return Song(
      imageUrl: imageUrl ?? this.imageUrl,
      name: name ?? this.name,
      albumName: albumName ?? this.albumName,
      mp3Url: mp3Url ?? this.mp3Url,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'imageUrl': imageUrl,
      'name': name,
      'albumName': albumName,
      'mp3Url': mp3Url,
    };
  }

  factory Song.fromMap(Map<String, dynamic> map) {
    return Song(
      imageUrl: map['imageUrl'] as String,
      name: map['name'] as String,
      albumName: map['albumName'] as String,
      mp3Url: map['mp3Url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Song.fromJson(String source) =>
      Song.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Song(imageUrl: $imageUrl, name: $name, albumName: $albumName, mp3Url: $mp3Url)';
  }

  @override
  bool operator ==(covariant Song other) {
    if (identical(this, other)) return true;

    return other.imageUrl == imageUrl &&
        other.name == name &&
        other.albumName == albumName &&
        other.mp3Url == mp3Url;
  }

  @override
  int get hashCode {
    return imageUrl.hashCode ^
        name.hashCode ^
        albumName.hashCode ^
        mp3Url.hashCode;
  }
}
