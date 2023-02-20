import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:mousika/components/music_card.dart';
import 'package:mousika/components/music_image.dart';
import 'package:mousika/config/config.dart';
import 'package:mousika/screens/musicPlayer/music_player.dart';
import 'package:mousika/services/goto.dart';

import '../manager/page_manager.dart';
import '../services/service_locator.dart';

class MusicContainer extends StatelessWidget {
  final MediaItem currentSong;
  final bool gotoNextPage;

  const MusicContainer({
    super.key,
    required this.currentSong,
    required this.gotoNextPage,
  });

  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        pageManager.playSpecificSong(currentSong);
        pageManager.play();

        if (gotoNextPage) {
          // hide keyboard programaticlly first to avoid renderflex error
          FocusScope.of(context).unfocus();
          goto(context, MusicPlayer(currentSong: currentSong));
        }
      },
      child: ValueListenableBuilder<MediaItem>(
        valueListenable: pageManager.currentSongNotifier,
        builder: (_, song, __) {
          return Container(
            margin: const EdgeInsets.symmetric(
              vertical: Sizes.defaultPadding * 0.1,
              horizontal: Sizes.defaultPadding * 0.5,
            ),
            decoration: BoxDecoration(
              color: song == currentSong
                  ? theme.colorScheme.secondary.withOpacity(0.5)
                  : null,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: Sizes.defaultPadding * 0.5,
              ),
              dense: true,
              leading: currentSong.extras!['image'] == null
                  ? const MusicCard(
                      width: 80,
                      height: double.maxFinite,
                      icon: Icons.music_note_rounded,
                      size: 40,
                      opacity: 0.0,
                    )
                  : MusicImage(image: currentSong.extras!['image']),
              title: Text(
                currentSong.title,
                overflow: TextOverflow.ellipsis,
                semanticsLabel: "song name",
                style: theme.textTheme.titleSmall!.copyWith(
                  color: song == currentSong ? theme.colorScheme.primary : null,
                ),
              ),
              subtitle: Text(
                currentSong.artist ?? "",
                semanticsLabel: "artist name",
                style: theme.textTheme.titleSmall!.copyWith(
                  fontSize: 10,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
