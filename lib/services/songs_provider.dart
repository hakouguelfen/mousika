import 'package:audio_service/audio_service.dart';
import 'dart:core';
import 'dart:typed_data';

import 'package:on_audio_query/on_audio_query.dart';

class Songs {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  List<MediaItem> playList = [];

  // Retreive all songs in the device fileSystem
  Future getSongs() async {
    List<SongModel> songs = await _audioQuery.querySongs();

    for (var song in songs) {
      Uint8List? image = await _audioQuery.queryArtwork(
        song.id,
        ArtworkType.AUDIO,
        format: ArtworkFormat.PNG,
      );

      playList.add(
        MediaItem(
          id: song.data,
          title: song.title,
          artist: song.artist,
          album: song.album,
          extras: {'image': image},
        ),
      );
    }
    return playList;
  }

  Future getSongsByArtist() async {
    return await _audioQuery.queryAlbums();
  }
}
