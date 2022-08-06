import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:mousika/components/music_container.dart';
import 'package:mousika/config/config.dart';
import 'package:mousika/manager/page_manager.dart';
import 'package:mousika/services/service_locator.dart';

class AllSongs extends StatelessWidget {
  const AllSongs({super.key});

  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();

    return Padding(
      padding: const EdgeInsets.only(top: Sizes.defaultPadding * 2),
      child: ValueListenableBuilder<List<MediaItem>>(
        valueListenable: pageManager.playlistNotifier,
        builder: (_, playlist, __) {
          return ListView.builder(
            itemCount: playlist.length,
            itemBuilder: (context, index) {
              return MusicContainer(
                currentSong: playlist[index],
                gotoNextPage: false,
              );
            },
          );
        },
      ),
    );
  }
}
