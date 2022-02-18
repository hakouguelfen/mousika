import 'dart:convert';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouriteSongs with ChangeNotifier {
  ValueNotifier<List<String>> favouriteSongs = ValueNotifier([]);

  SharedPreferences? _prefs;

  Future init() async {
    _prefs = await SharedPreferences.getInstance();
    favouriteSongs.value = _prefs?.getStringList('favouriteSong') ?? [];
  }

  void addSong(MediaItem song) {
    SongMetadata _songMetadata = SongMetadata(
      id: song.id,
      title: song.title,
      artist: song.artist ?? '',
    );

    favouriteSongs.value.add(jsonEncode(_songMetadata));
    _prefs?.setStringList('favouriteSong', favouriteSongs.value);

    favouriteSongs.notifyListeners();
  }

  void removeSong(MediaItem song) {
    SongMetadata _songMetadata = SongMetadata(
      id: song.id,
      title: song.title,
      artist: song.artist ?? '',
    );

    favouriteSongs.value.remove(jsonEncode(_songMetadata));
    _prefs?.setStringList('favouriteSong', favouriteSongs.value);

    favouriteSongs.notifyListeners();
  }
}

class SongMetadata {
  String id;
  String title;
  String artist;

  SongMetadata({required this.id, required this.title, required this.artist});

  SongMetadata.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        artist = json['artist'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'artist': artist,
      };
}
