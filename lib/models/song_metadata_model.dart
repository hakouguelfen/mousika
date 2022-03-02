import 'dart:typed_data';

class SongMetadata {
  String? id;
  String? title;
  String? artist;
  String? album;
  Uint8List? image;

  SongMetadata({
    this.id,
    this.title,
    this.artist,
    this.album,
    this.image,
  });

  SongMetadata.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        artist = json['artist'],
        album = json['album'],
        image = json['image'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'artist': artist,
        'album': album,
        'image': image,
      };
}
