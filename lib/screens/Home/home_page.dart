import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:music_play/components/bottom_music_controller.dart';
import 'package:music_play/manager/page_manager.dart';
import 'package:music_play/services/service_locator.dart';

import 'package:music_play/constants.dart';

import '../../components/favorite_music.dart';
import '../../components/music_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _MusicListState();
}

class _MusicListState extends State<HomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final pageManager = getIt<PageManager>();
    List<String> songs_types = ['artists', 'albums', 'genre'];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            snap: false,
            floating: true,
            expandedHeight: 160.0,
            elevation: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: Text(
              'Mousika',
              style:
                  Theme.of(context).textTheme.headline6!.copyWith(fontSize: 18),
            ),
            leading: const Padding(
              padding: EdgeInsets.all(defaultPadding * 0.5),
              child: Image(image: AssetImage('assets/icons/logo.png')),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      height: 40,
                      margin: const EdgeInsets.only(top: 100, left: 10),
                      child: const Center(
                        child: Text(
                          "all songs",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    SizedBox(
                      height: 140,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Container(
                            width: 100,
                            margin: const EdgeInsets.only(top: 100, left: 10),
                            child: Center(
                              child: Text(songs_types[index]),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                              ),
                            ),
                          );
                        },
                        itemCount: songs_types.length,
                        scrollDirection: Axis.horizontal,
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ValueListenableBuilder<List<MediaItem>>(
                  valueListenable: pageManager.playlistNotifier,
                  builder: (_, playlist, __) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding * 0.5,
                      ),
                      child: MusicContainer(
                        currentSong: playlist[index],
                        gotoNextPage: false,
                      ),
                    );
                  },
                );
              },
              childCount: 2,
            ),
          ),
        ],
      ),
      bottomNavigationBar: ValueListenableBuilder<MediaItem>(
        valueListenable: pageManager.currentSongNotifier,
        builder: (_, song, __) {
          return BottomMusicController(currentSong: song);
        },
      ),
    );
  }
}
