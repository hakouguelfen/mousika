import 'dart:convert';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:music_play/constants.dart';
import 'package:music_play/manager/page_manager.dart';
import 'package:music_play/notifiers/play_button_notifier.dart';
import 'package:music_play/screens/musicPlayer/components/music_description.dart';
import 'package:music_play/screens/musicPlayer/components/music_slider.dart';
import 'package:music_play/services/convert_song.dart';
import 'package:music_play/services/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'components/music_image_cover.dart';
import 'components/music_play_button.dart';
import 'services/favourite_music_service.dart';

class MusicPlayer extends StatefulWidget {
  final MediaItem currentSong;
  const MusicPlayer({Key? key, required this.currentSong}) : super(key: key);

  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  static bool isCurrentSong = true;
  final pageManager = getIt<PageManager>();

  final favouriteSongs = getIt<FavouriteSongs>();
  final convertSong = ConvertSong();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<bool> _isFavourite;

  @override
  void initState() {
    super.initState();
    if (widget.currentSong != pageManager.currentSongNotifier.value) {
      isCurrentSong = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    _isFavourite = _prefs.then((SharedPreferences prefs) {
      return prefs.getStringList('favouriteSong')!.contains(
            json.encode(
              convertSong.toSongMetadata(widget.currentSong),
            ),
          );
    });

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
        actions: [
          FutureBuilder<bool>(
            future: _isFavourite,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return IconButton(
                onPressed: () {
                  snapshot.data
                      ? favouriteSongs.removeSong(widget.currentSong)
                      : favouriteSongs.addSong(widget.currentSong);
                  setState(() {});
                },
                icon: favouriteSongStateIcon(snapshot.data ?? false),
              );
            },
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: MusicImageCover(
                  currentSong: widget.currentSong,
                ),
              ),
              Expanded(
                flex: 1,
                child: MusicDescription(
                  isCurrentSong: isCurrentSong,
                  currentSong: widget.currentSong,
                ),
              ),
              musicController()
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                heroTag: null,
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
        const SizedBox(height: defaultPadding * 1.3),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton.large(
              heroTag: null,
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

  Icon favouriteSongStateIcon(bool isFavourite) {
    return isFavourite
        ? const Icon(Icons.favorite_rounded, size: 30, color: Colors.green)
        : const Icon(Icons.favorite_outline, size: 30);
  }
}
