import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:music_play/components/music_card.dart';
import 'package:music_play/components/song_info.dart';
import 'package:music_play/constants.dart';
import 'package:music_play/notifiers/progressbar_notifier.dart';
import 'package:music_play/screens/musicPlayer/music_player.dart';

import '../manager/page_manager.dart';
import '../notifiers/play_button_notifier.dart';
import '../services/service_locator.dart';

class BottomMusicController extends StatelessWidget {
  final MediaItem currentSong;
  const BottomMusicController({Key? key, required this.currentSong})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final pageManager = getIt<PageManager>();

    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 700),
            pageBuilder: (context, animation, _) => MusicPlayer(
              currentSong: currentSong,
            ),
          ),
        );
      },
      child: Container(
        width: double.maxFinite,
        height: height * 0.08,
        margin: const EdgeInsets.only(
          left: defaultPadding * 0.5,
          right: defaultPadding * 0.5,
          top: defaultPadding,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            ValueListenableBuilder<ProgressBarState>(
              valueListenable: pageManager.progressNotifier,
              builder: (_, progressVal, __) {
                final psongProgess = progressVal.current.inSeconds.toDouble() *
                    (width - defaultPadding) /
                    progressVal.total.inSeconds.toDouble();

                return AnimatedContainer(
                  constraints: const BoxConstraints(
                    maxWidth: double.maxFinite,
                    minWidth: 0.0,
                  ),
                  width: psongProgess,
                  height: height * 0.1,
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastOutSlowIn,
                  color: Theme.of(context)
                      .scaffoldBackgroundColor
                      .withOpacity(0.4),
                );
              },
            ),
            Row(
              children: [
                Hero(
                  tag: 'song${currentSong.title}',
                  transitionOnUserGestures: true,
                  createRectTween: (begin, end) {
                    return MaterialRectCenterArcTween(begin: begin, end: end);
                  },
                  child: currentSong.extras == null ||
                          currentSong.extras!['image'] == null
                      ? const MusicCard(
                          width: 80,
                          height: double.maxFinite,
                          icon: Icons.music_note_rounded,
                          size: 40,
                          opacity: 0.0,
                        )
                      : musicImage(currentSong.extras!['image']),
                ),
                const SizedBox(width: defaultPadding * 0.7),
                Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: SongInfo(
                    title: currentSong.title,
                    artist: currentSong.artist ?? '',
                    size: 0.01,
                    fontSize: 18,
                  ),
                ),
                ValueListenableBuilder<ButtonState>(
                  valueListenable: pageManager.playButtonNotifier,
                  builder: (_, buttonState, __) {
                    return Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: InkWell(
                        onTap: () {
                          buttonState == ButtonState.paused
                              ? pageManager.play()
                              : pageManager.pause();
                        },
                        child: Icon(
                          buttonState == ButtonState.paused
                              ? Icons.play_arrow_rounded
                              : Icons.pause,
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container musicImage(image) {
    return Container(
      width: 80,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: MemoryImage(image),
          fit: BoxFit.cover,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
      ),
    );
  }
}
