import 'dart:convert';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:music_play/components/song_info.dart';
import 'package:music_play/manager/page_manager.dart';
import 'package:music_play/screens/musicPlayer/music_player.dart';
import 'package:music_play/services/convert_song.dart';
import 'package:music_play/services/service_locator.dart';

import '../constants.dart';
import '../screens/musicPlayer/services/favourite_music_service.dart';

class FavouriteMusic extends StatelessWidget {
  FavouriteMusic({Key? key}) : super(key: key);

  final pageManager = getIt<PageManager>();
  final favouriteSongs = getIt<FavouriteSongs>();
  final convertSong = ConvertSong();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<String>>(
      valueListenable: favouriteSongs.favouriteSongs,
      builder: (_, songs, __) {
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: songs.length,
          itemBuilder: (context, index) {
            MediaItem song = convertSong.toMediaItem(jsonDecode(songs[index]));

            return InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => MusicPlayer(currentSong: song),
                  ),
                );
              },
              child: Container(
                width: 200,
                height: double.maxFinite,
                margin: const EdgeInsets.symmetric(
                  horizontal: defaultPadding * 0.7,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding * 0.7,
                ),
                child: Column(
                  children: [
                    const Expanded(
                      flex: 3,
                      child: SizedBox(
                        width: double.maxFinite,
                        child: Icon(
                          Icons.music_note_rounded,
                          color: Colors.blueAccent,
                          size: 60,
                        ),
                      ),
                    ),
                    Expanded(
                      child: SongInfo(
                        title: song.title,
                        artist: song.artist ?? '',
                        size: 0,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(defaultBorderRaduis),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
