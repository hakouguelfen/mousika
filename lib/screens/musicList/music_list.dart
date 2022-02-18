import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:music_play/manager/page_manager.dart';
import 'package:music_play/notifiers/progressbar_notifier.dart';
import 'package:music_play/services/service_locator.dart';

import 'package:music_play/constants.dart';

import '../../components/favorite_music.dart';
import '../../components/music_container.dart';

class MusicList extends StatefulWidget {
  const MusicList({Key? key}) : super(key: key);

  @override
  State<MusicList> createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final pageManager = getIt<PageManager>();

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => setState(() => currentIndex = index),
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_rounded),
            label: 'search',
          ),
        ],
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
      ),
      // bottomNavigationBar: const BottomMusicController(),
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
                  'Favorite Music',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: height * 0.03),
                FavouriteMusic(),
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
                                  songMetaData: playlist[index],
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

class BottomMusicController extends StatelessWidget {
  const BottomMusicController({Key? key}) : super(key: key);

  Container musicImage() {
    return Container(
      width: 80,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/arcade.png'),
          fit: BoxFit.fill,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Container(
      width: double.maxFinite,
      height: height * 0.08,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Hero(
                  tag: 'songColor',
                  transitionOnUserGestures: true,
                  createRectTween: (begin, end) {
                    return MaterialRectCenterArcTween(begin: begin, end: end);
                  },
                  child: musicImage(),
                ),
                const SizedBox(width: defaultPadding * 0.7),
                Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Color out music',
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontSize: 18,
                            ),
                      ),
                      SizedBox(height: height * 0.01),
                      Text(
                        'The Beatles',
                        style: TextStyle(
                          color: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .color!
                              .withOpacity(0.65),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Icon(
                    Icons.favorite_outline_rounded,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Icon(
                    Icons.play_arrow_rounded,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.maxFinite,
            height: 2,
            padding:
                const EdgeInsets.symmetric(horizontal: defaultPadding * 0.2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: const LinearProgressIndicator(
              value: 50,
              backgroundColor: Colors.red,
              semanticsLabel: 'progess',
            ),
          ),
        ],
      ),
    );
  }
}
