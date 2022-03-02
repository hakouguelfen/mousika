import 'package:audio_service/audio_service.dart';

import '../models/song_metadata_model.dart';

class ConvertSong {
  toMediaItem(song) {
    return MediaItem(
      id: song['id'],
      title: song['title'],
      artist: song['artist'],
      album: song['album'],
      extras: {'image': song['image']},
    );
  }

  toSongMetadata(song) {
    return SongMetadata(
      id: song.id,
      title: song.title,
      artist: song.artist ?? '',
      album: song.album,
      image: song.extras['image'],
    );
  }
}
