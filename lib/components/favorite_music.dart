import 'dart:convert';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:music_play/components/music_card.dart';
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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                constraints: const BoxConstraints(
                  maxHeight: 100,
                  minHeight: 50,
                ),
                isScrollControlled: true,
                builder: (context) => Center(
                  child: Column(
                    children: [
                      Container(
                        width: 100,
                        height: 5,
                        margin: const EdgeInsets.all(defaultPadding * 0.5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey,
                        ),
                      ),
                      Text('hakou'),
                    ],
                  ),
                ),
              );
            },
            child: const MusicCard(
              width: 200,
              height: double.maxFinite,
              icon: Icons.add_rounded,
              size: 70,
              opacity: 1,
            ),
          ),
          ValueListenableBuilder<List<String>>(
            valueListenable: favouriteSongs.favouriteSongs,
            builder: (_, songs, __) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: songs.length,
                itemBuilder: (context, index) {
                  MediaItem song =
                      convertSong.toMediaItem(jsonDecode(songs[index]));

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
                              color:
                                  Theme.of(context).textTheme.bodyText2!.color!,
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
          ),
        ],
      ),
    );
  }
}
