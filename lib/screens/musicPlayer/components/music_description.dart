import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:music_play/manager/page_manager.dart';
import 'package:music_play/services/service_locator.dart';

class MusicDescription extends StatelessWidget {
  const MusicDescription({
    Key? key,
    required this.isCurrentSong,
    required this.currentSong,
  }) : super(key: key);
  final bool isCurrentSong;
  final MediaItem currentSong;

  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();

    return ValueListenableBuilder<MediaItem>(
      valueListenable: pageManager.currentSongNotifier,
      builder: (_, song, __) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              isCurrentSong ? song.title : currentSong.title,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
              softWrap: true,
            ),
            // const SizedBox(height: defaultPadding),
            Text(
              isCurrentSong ? song.artist ?? '' : currentSong.artist ?? '',
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w100,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        );
      },
    );
  }
}
