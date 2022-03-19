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
      Uint8List? image =
          await _audioQuery.queryArtwork(song.id, ArtworkType.AUDIO);
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

    // List titles = [];
    // List indexs = [];

    // playList.asMap().forEach((index, song) {
    //   !titles.contains(song.title) ? titles.add(song.title) : indexs.add(index);
    // });

    // int i = 0;
    // for (var index in indexs) {
    //   playList.removeAt(index - i);
    //   i++;
    // }
    return playList;
  }
}
