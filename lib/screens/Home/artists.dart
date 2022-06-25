import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:music_play/components/music_container.dart';
import 'package:music_play/constants.dart';
import 'package:music_play/manager/page_manager.dart';
import 'package:music_play/services/service_locator.dart';
import 'package:music_play/services/songs_provider.dart';

class Artists extends StatelessWidget {
  const Artists({super.key});

  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    Songs().getSongsByArtist();

    return Padding(
      padding: const EdgeInsets.only(top: defaultPadding * 2),
      child: GridView.count(
        crossAxisCount: 2,
        children: [
          Card(
            color: Theme.of(context).cardColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 130,
                ),
                Text('artistName')
              ],
            ),
          ),
          Card(
            color: Theme.of(context).cardColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 130,
                ),
                Text('artistName')
              ],
            ),
          ),
          Card(
            color: Theme.of(context).cardColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 130,
                ),
                Text('artistName')
              ],
            ),
          ),
          Card(
            color: Theme.of(context).cardColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 130,
                ),
                Text('artistName')
              ],
            ),
          ),
        ],
      ),
    );
    // return Padding(
    //   padding: const EdgeInsets.only(top: defaultPadding * 2),
    //   child: ValueListenableBuilder<List<MediaItem>>(
    //     valueListenable: pageManager.playlistNotifier,
    //     builder: (_, playlist, __) {
    //       return ListView.builder(
    //         itemCount: playlist.length,
    //         itemBuilder: (context, index) {
    //           return MusicContainer(
    //             currentSong: playlist[index],
    //             gotoNextPage: false,
    //           );
    //         },
    //       );
    //     },
    //   ),
    // );
  }
}
