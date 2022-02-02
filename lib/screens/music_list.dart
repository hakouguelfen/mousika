import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:music_play/manager/page_manager.dart';
import 'package:music_play/services/service_locator.dart';

import 'package:music_play/constants.dart';

import '../components/favorite_music.dart';
import '../components/music_container.dart';

class MusicList extends StatefulWidget {
  const MusicList({Key? key}) : super(key: key);

  @override
  State<MusicList> createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final pageManager = getIt<PageManager>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: width * 0.02),
            child: GestureDetector(
              onTap: () {
                // pageManager.add();
              },
              child: const Icon(Icons.nightlight),
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
                const FavoriteMusic(),
                SizedBox(height: height * 0.03),
                Text(
                  'All Songs',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: height * 0.03),
                ValueListenableBuilder<List<MediaItem>>(
                  valueListenable: pageManager.playlistNotifier,
                  builder: (context, playlistTitles, _) {
                    return ListView.builder(
                      itemCount: playlistTitles.length,
                      itemBuilder: (BuildContext context, int index) {
                        return MusicContainer(
                          songMetaData: playlistTitles[index],
                        );
                      },
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
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
