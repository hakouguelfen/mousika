import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:music_play/manager/page_manager.dart';
import 'package:music_play/notifiers/progressbar_notifier.dart';
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final pageManager = getIt<PageManager>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: width * 0.02),
            child: GestureDetector(
              onTap: () {
                // pageManager.add();
              },
              child: Icon(
                Icons.nightlight,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding * 0.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.02),
                Text(
                  'My PlayLists',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: height * 0.03),
                SizedBox(
                  height: height * 0.2,
                  child: FavouriteMusic(),
                ),
                // SingleChildScrollView(
                //   // height: height * 0.2,
                //   // width: 500,
                //   // child: FavouriteMusic(),
                //   child: Row(
                //     children: [
                //       Container(
                //         margin: const EdgeInsets.all(10),
                //         color: Colors.amber,
                //         width: 200,
                //         height: 200,
                //       ),
                //       SizedBox(
                //         width: 500,
                //         height: 200,
                //         child: ListView.builder(
                //           itemCount: 3,
                //           scrollDirection: Axis.horizontal,
                //           physics: const ClampingScrollPhysics(),
                //           shrinkWrap: false,
                //           itemBuilder: (BuildContext context, int index) {
                //             return Container(
                //               margin: const EdgeInsets.all(10),
                //               color: Colors.red,
                //               width: 200,
                //               height: 200,
                //             );
                //           },
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                SizedBox(height: height * 0.03),
                Text(
                  'All Songs',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: height * 0.03),

                //TODO: This should be fixed (Nested ValueListenableBuilder)
                ValueListenableBuilder<List<MediaItem>>(
                  valueListenable: pageManager.playlistNotifier,
                  builder: (_, playlist, __) {
                    // listen to progress bar changes
                    return ValueListenableBuilder<ProgressBarState>(
                      valueListenable: pageManager.progressNotifier,
                      builder: (_, progressVal, __) {
                        // listen for current playing song
                        return ValueListenableBuilder<MediaItem>(
                          valueListenable: pageManager.currentSongNotifier,
                          builder: (_, song, __) {
                            return ListView.builder(
                              itemCount: playlist.length,
                              itemBuilder: (BuildContext context, int index) {
                                final psongProgess =
                                    progressVal.current.inSeconds.toDouble() *
                                        (width - defaultPadding) /
                                        progressVal.total.inSeconds.toDouble();

                                return MusicContainer(
                                  containerWidth: playlist[index] == song
                                      ? psongProgess
                                      : 0,
                                  currentSong: playlist[index],
                                );
                              },
                              physics: const ClampingScrollPhysics(),
                              shrinkWrap: true,
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
