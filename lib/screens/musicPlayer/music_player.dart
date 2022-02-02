import 'dart:ffi';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:music_play/constants.dart';
import 'package:music_play/manager/page_manager.dart';
import 'package:music_play/notifiers/play_button_notifier.dart';
import 'package:music_play/notifiers/progressbar_notifier.dart';
import 'package:music_play/screens/musicPlayer/components/music_slider.dart';
import 'package:music_play/services/service_locator.dart';
import 'components/music_image_cover.dart';

class MusicPlayer extends StatefulWidget {
  final MediaItem songMetaData;
  const MusicPlayer({Key? key, required this.songMetaData}) : super(key: key);

  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  bool isFavourite = false;
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
        title: currentSong
            ? ValueListenableBuilder<ButtonState>(
                valueListenable: pageManager.playButtonNotifier,
                builder: (_, buttonState, __) {
                  return Text(
                    buttonState == ButtonState.loading
                        ? ''
                        : buttonState == ButtonState.paused
                            ? 'Stoped'
                            : 'Playing now',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                  );
                },
              )
            : Text(
                'Stoped',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
              ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              const MusicImageCover(),
              musicDescription(),
              MusicSlider(currentSong: currentSong),
              musicController(),
            ],
          ),
        ),
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

  Expanded musicDescription() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ValueListenableBuilder<MediaItem>(
            valueListenable: pageManager.currentSongNotifier,
            builder: (_, song, __) {
              return currentSong
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          song.title,
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          song.artist ?? '',
                          style: TextStyle(
                            color: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .color!
                                .withOpacity(0.65),
                          ),
                        )
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.songMetaData.title,
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          widget.songMetaData.artist ?? '',
                          style: TextStyle(
                            color: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .color!
                                .withOpacity(0.65),
                          ),
                        ),
                      ],
                    );
            },
          ),
          InkWell(
            onTap: () => setState(() => isFavourite = !isFavourite),
            child: favouriteSongStateIcon(),
          ),
        ],
      ),
    );
  }

  Icon musicStateIcon(bool _buttonState) {
    return _buttonState
        ? const Icon(Icons.arrow_right_rounded, size: 40)
        : const Icon(Icons.pause);
  }

  Icon favouriteSongStateIcon() {
    return isFavourite
        ? const Icon(Icons.favorite_rounded, size: 30, color: Colors.green)
        : const Icon(Icons.favorite_outline, size: 30);
  }
}

class PlayButton extends StatelessWidget {
  final VoidCallback press;
  final bool buttonState;
  const PlayButton({Key? key, required this.press, required this.buttonState})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: press,
      child: musicStateIcon(buttonState),
      backgroundColor: Theme.of(context).colorScheme.primary,
    );
  }

  Icon musicStateIcon(bool _buttonState) {
    return _buttonState
        ? const Icon(Icons.arrow_right_rounded, size: 40)
        : const Icon(Icons.pause);
  }
}
