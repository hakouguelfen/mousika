import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:music_play/components/bottom_music_controller.dart';
import 'package:music_play/manager/page_manager.dart';
import 'package:music_play/screens/Home/all_songs.dart';
import 'package:music_play/services/service_locator.dart';

import 'package:music_play/constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const List<Tab> myTabs = <Tab>[
      Tab(child: Text('all songs')),
      Tab(child: Text('artists')),
    ];
    final pageManager = getIt<PageManager>();

    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: buildAppBar(context, myTabs),
        body: TabBarView(
          children: const [
            AllSongs(),
            Text('artists'),
          ],
        ),
        bottomNavigationBar: ValueListenableBuilder<MediaItem>(
          valueListenable: pageManager.currentSongNotifier,
          builder: (_, song, __) {
            return BottomMusicController(currentSong: song);
          },
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context, List<Tab> myTabs) {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: Text(
        'Mousika',
        style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 18),
      ),
      leading: const Padding(
        padding: EdgeInsets.all(defaultPadding * 0.5),
        child: Image(image: AssetImage('assets/icons/logo.png')),
      ),
      bottom: TabBar(
        indicator: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(defaultBorderRaduis),
        ),
        tabs: myTabs,
      ),
    );
  }
}
