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
  final MediaItem songMetaData;
  const MusicPlayer({Key? key, required this.songMetaData}) : super(key: key);

  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  bool currentSong = true;
  final pageManager = getIt<PageManager>();

  @override
  void initState() {
    super.initState();
    if (widget.songMetaData != pageManager.currentSongNotifier.value) {
      currentSong = !currentSong;
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
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              MusicImageCover(
                songMetaData: widget.songMetaData,
              ),
              MusicDescription(
                currentSong: currentSong,
                songMetaData: widget.songMetaData,
              ),
              MusicSlider(currentSong: currentSong),
              musicController(),
            ],
          ),
        ),
      ),
    );
  }

  Widget musicTitle() {
    return currentSong
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

  Expanded musicController() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () => pageManager.previous(),
            icon: Icon(
              Icons.skip_previous_rounded,
              size: Theme.of(context).iconTheme.size,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          ValueListenableBuilder<ButtonState>(
              valueListenable: pageManager.playButtonNotifier,
              builder: (_, buttonState, __) {
                return currentSong
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
                            currentSong = !currentSong;
                            pageManager.playSpecificSong(widget.songMetaData);
                            pageManager.play();
                          });
                        },
                        buttonState: true,
                      );
              }),
          IconButton(
            onPressed: () => pageManager.next(),
            icon: Icon(
              Icons.skip_next_rounded,
              size: Theme.of(context).iconTheme.size,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
        ],
      ),
    );
  }
}
