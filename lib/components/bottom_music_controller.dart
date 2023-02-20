import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:mousika/components/music_card.dart';
import 'package:mousika/components/music_image.dart';
import 'package:mousika/components/song_info.dart';
import 'package:mousika/config/config.dart';
import 'package:mousika/notifiers/play_button_notifier.dart';
import 'package:mousika/notifiers/progressbar_notifier.dart';
import 'package:mousika/screens/musicPlayer/music_player.dart';
import 'package:mousika/services/goto.dart';

import '../manager/page_manager.dart';
import '../services/service_locator.dart';

class BottomMusicController extends StatelessWidget {
  final MediaItem currentSong;
  const BottomMusicController({super.key, required this.currentSong});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);
    final pageManager = getIt<PageManager>();

    return InkWell(
      onTap: () {
        goto(context, MusicPlayer(currentSong: currentSong));
      },
      child: Stack(
        children: [
          ValueListenableBuilder<ProgressBarState>(
            valueListenable: pageManager.progressNotifier,
            builder: (_, progressVal, __) {
              final psongProgess = progressVal.current.inSeconds.toDouble() *
                  (width - Sizes.defaultPadding) /
                  progressVal.total.inSeconds.toDouble();

              return AnimatedContainer(
                constraints: const BoxConstraints(
                  maxWidth: double.maxFinite,
                  minWidth: 0.0,
                ),
                width: psongProgess,
                height: height * 0.07,
                duration: const Duration(seconds: 1),
                curve: Curves.fastOutSlowIn,
                decoration: BoxDecoration(
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.36),
                  borderRadius: BorderRadius.circular(10),
                ),
              );
            },
          ),
          ListTile(
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
                color: theme.colorScheme.primary,
              ),
            ),
            subtitle: Text(
              currentSong.artist ?? "",
              semanticsLabel: "artist name",
              style: theme.textTheme.titleSmall!.copyWith(
                fontSize: 10,
              ),
            ),
            trailing: ValueListenableBuilder<ButtonState>(
              valueListenable: pageManager.playButtonNotifier,
              builder: (_, buttonState, __) {
                return IconButton(
                  onPressed: () {
                    buttonState == ButtonState.paused
                        ? pageManager.play()
                        : pageManager.pause();
                  },
                  icon: Icon(
                    buttonState == ButtonState.paused
                        ? Icons.play_arrow_rounded
                        : Icons.pause,
                    color: Theme.of(context).iconTheme.color,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
