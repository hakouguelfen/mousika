import 'dart:convert';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:music_play/models/song_metadata_model.dart';
import 'package:music_play/services/convert_song.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouriteSongs with ChangeNotifier {
  // presist the favourite songs values through out the app
  ValueNotifier<List<String>> favouriteSongs = ValueNotifier([]);
  SharedPreferences? _prefs;
  final convertSong = ConvertSong();

  Future init() async {
    _prefs = await SharedPreferences.getInstance();

    if (_prefs?.getStringList('favouriteSong') == null) {
      _prefs?.setStringList('favouriteSong', []);
    }

    favouriteSongs.value = _prefs?.getStringList('favouriteSong') ?? [];
  }

  void addSong(MediaItem song) {
    // convert MediaItem ot SongMetadata class so we can:
    // encode it and decode it with json, to save it in the shared preference
    // list (must only contain Strings)

    SongMetadata _songMetadata = convertSong.toSongMetadata(song);

    favouriteSongs.value.add(json.encode(_songMetadata));
    _prefs?.setStringList('favouriteSong', favouriteSongs.value);

    // update the UI
    favouriteSongs.notifyListeners();
  }

  void removeSong(MediaItem song) {
    // convert MediaItem to SongMetadata class so we can:
    // encode it and decode it with json, to save it in the shared preference
    // list (must only contain Strings)

    SongMetadata _songMetadata = convertSong.toSongMetadata(song);

    favouriteSongs.value.remove(jsonEncode(_songMetadata));
    _prefs?.setStringList('favouriteSong', favouriteSongs.value);

    // update the UI
    favouriteSongs.notifyListeners();
  }
}
