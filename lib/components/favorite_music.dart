import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:music_play/manager/page_manager.dart';
import 'package:music_play/screens/musicPlayer/music_player.dart';
import 'package:music_play/services/service_locator.dart';

import '../constants.dart';
import '../screens/musicPlayer/services/favourite_music_service.dart';

class FavouriteMusic extends StatelessWidget {
  FavouriteMusic({Key? key}) : super(key: key);

  final pageManager = getIt<PageManager>();
  final favouriteSongs = getIt<FavouriteSongs>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return SizedBox(
      height: height * 0.2,
      child: ValueListenableBuilder<List<String>>(
        valueListenable: favouriteSongs.favouriteSongs,
        builder: (_, songs, __) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: songs.length,
            itemBuilder: (context, index) {
              var song = jsonDecode(songs[index]);

              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => MusicPlayer(
                        songMetaData: song,
                      ),
                    ),
                  );
                },
                child: Hero(
                  tag: 'songs${song['title']}',
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
                          child: Column(
                            children: [
                              SizedBox(
                                width: double.maxFinite,
                                child: Text(
                                  song['title'],
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                        fontSize: 16,
                                      ),
                                ),
                              ),
                              SizedBox(
                                width: double.maxFinite,
                                child: Text(
                                  song['artist'],
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .color!
                                        .withOpacity(0.65),
                                  ),
                                ),
                              ),
                            ],
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
                ),
              );
            },
          );
        },
      ),
    );
  }
}
