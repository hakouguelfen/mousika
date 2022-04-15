import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';

import '../../components/music_container.dart';
import '../../constants.dart';
import '../../manager/page_manager.dart';
import '../../services/service_locator.dart';

class AllSongs extends StatelessWidget {
  const AllSongs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();

    return Padding(
      padding: const EdgeInsets.only(top: defaultPadding),
      child: ValueListenableBuilder<List<MediaItem>>(
        valueListenable: pageManager.playlistNotifier,
        builder: (_, playlist, __) {
          return ListView.builder(
            itemCount: playlist.length,
            itemBuilder: (context, index) {
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
      ),
    );
  }
}
