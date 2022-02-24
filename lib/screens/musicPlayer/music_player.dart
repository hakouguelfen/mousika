import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:music_play/constants.dart';
import 'package:music_play/manager/page_manager.dart';
import 'package:music_play/notifiers/play_button_notifier.dart';
import 'package:music_play/screens/musicPlayer/components/music_description.dart';
import 'package:music_play/screens/musicPlayer/components/music_slider.dart';
import 'package:music_play/services/service_locator.dart';
import 'components/music_image_cover.dart';
import 'components/music_play_button.dart';

class MusicPlayer extends StatefulWidget {
  final MediaItem currentSong;
  const MusicPlayer({Key? key, required this.currentSong}) : super(key: key);

  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  static bool isCurrentSong = true;
  final pageManager = getIt<PageManager>();

  @override
  void initState() {
    super.initState();
    if (widget.currentSong != pageManager.currentSongNotifier.value) {
      isCurrentSong = !isCurrentSong;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.chevron_left_rounded,
            size: Theme.of(context).iconTheme.size,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        title: musicTitle(),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              MusicImageCover(
                currentSong: widget.currentSong,
              ),
              MusicDescription(
                isCurrentSong: isCurrentSong,
                currentSong: widget.currentSong,
              ),
              musicController(),
            ],
          ),
        ),
      ),
    );
  }

  Widget musicTitle() {
    return isCurrentSong
        ? ValueListenableBuilder<ButtonState>(
            valueListenable: pageManager.playButtonNotifier,
            builder: (_, buttonState, __) {
              return Text(
                buttonState == ButtonState.loading
                    ? ''
                    : buttonState == ButtonState.paused
                        ? 'Stopped'
                        : 'Playing now',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
              );
            },
          )
        : Text(
            'Stopped',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
          );
  }

  Column musicController() {
    return Column(
      children: [
        // First Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: ValueListenableBuilder<ButtonState>(
                  valueListenable: pageManager.playButtonNotifier,
                  builder: (_, buttonState, __) {
                    return isCurrentSong
                        ? PlayButton(
                            press: () {
                              buttonState == ButtonState.paused
                                  ? pageManager.play()
                                  : pageManager.pause();
                            },
                            buttonState: buttonState == ButtonState.paused ||
                                buttonState == ButtonState.loading,
                          )
                        : PlayButton(
                            press: () {
                              setState(() {
                                isCurrentSong = !isCurrentSong;
                                pageManager
                                    .playSpecificSong(widget.currentSong);
                                pageManager.play();
                              });
                            },
                            buttonState: true,
                          );
                  }),
            ),
            Expanded(
              flex: 1,
              child: FloatingActionButton.large(
                onPressed: () => pageManager.next(),
                child: Icon(
                  Icons.skip_next_rounded,
                  size: Theme.of(context).iconTheme.size,
                ),
                elevation: 0,
              ),
            ),
          ],
        ),
        // Second Row
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton.large(
              onPressed: () => pageManager.previous(),
              child: Icon(
                Icons.skip_previous_rounded,
                size: Theme.of(context).iconTheme.size,
              ),
              elevation: 0,
            ),
            Expanded(
              child: MusicSlider(isCurrentSong: isCurrentSong),
            ),
          ],
        )
      ],
    );
  }
}
