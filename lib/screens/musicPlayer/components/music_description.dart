import 'dart:convert';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:music_play/components/song_info.dart';
import 'package:music_play/manager/page_manager.dart';
import 'package:music_play/models/song_metadata_model.dart';
import 'package:music_play/services/convert_song.dart';
import 'package:music_play/services/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/favourite_music_service.dart';

class MusicDescription extends StatefulWidget {
  const MusicDescription({
    Key? key,
    required this.isCurrentSong,
    required this.currentSong,
  }) : super(key: key);

  final bool isCurrentSong;
  final MediaItem currentSong;
  @override
  State<MusicDescription> createState() => _MusicDescriptionState();
}

class _MusicDescriptionState extends State<MusicDescription> {
  final pageManager = getIt<PageManager>();
  final favouriteSongs = getIt<FavouriteSongs>();
  final convertSong = ConvertSong();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<bool> _isFavourite;

  @override
  Widget build(BuildContext context) {
    _isFavourite = _prefs.then((SharedPreferences prefs) {
      return prefs.getStringList('favouriteSong')!.contains(
            json.encode(
              convertSong.toSongMetadata(widget.currentSong),
            ),
          );
    });

    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ValueListenableBuilder<MediaItem>(
            valueListenable: pageManager.currentSongNotifier,
            builder: (_, song, __) {
              return widget.isCurrentSong
                  ? SongInfo(
                      title: song.title,
                      artist: song.artist ?? '',
                      size: 0.01,
                      fontSize: 22,
                    )
                  : SongInfo(
                      title: widget.currentSong.title,
                      artist: widget.currentSong.artist ?? '',
                      size: 0.01,
                      fontSize: 22,
                    );
            },
          ),
          FutureBuilder<bool>(
            future: _isFavourite,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return IconButton(
                onPressed: () {
                  snapshot.data
                      ? favouriteSongs.removeSong(widget.currentSong)
                      : favouriteSongs.addSong(widget.currentSong);
                  setState(() {});
                },
                icon: favouriteSongStateIcon(snapshot.data ?? false),
              );
            },
          )
        ],
      ),
    );
  }

  Icon favouriteSongStateIcon(bool isFavourite) {
    return isFavourite
        ? const Icon(Icons.favorite_rounded, size: 30, color: Colors.green)
        : const Icon(Icons.favorite_outline, size: 30);
  }
}
