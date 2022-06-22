import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:music_play/constants.dart';
import 'package:music_play/manager/page_manager.dart';
import 'package:music_play/notifiers/play_button_notifier.dart';
import 'package:music_play/screens/musicPlayer/components/music_description.dart';
import 'package:music_play/services/service_locator.dart';
import 'components/music_controller.dart';
import 'components/music_image_cover.dart';

class MusicPlayer extends StatefulWidget {
  final MediaItem currentSong;
  const MusicPlayer({super.key, required this.currentSong});

  @override
  MusicPlayerState createState() => MusicPlayerState();
}

class MusicPlayerState extends State<MusicPlayer> {
  final pageManager = getIt<PageManager>();

  @override
  void initState() {
    super.initState();

    pageManager.playSpecificSong(widget.currentSong);
    pageManager.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: ValueListenableBuilder<MediaItem>(
            valueListenable: pageManager.currentSongNotifier,
            builder: (_, song, __) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: MusicImageCover(
                      title: song.title,
                      image: song.extras?['image'],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: MusicDescription(currentSong: song),
                  ),
                  const MusicController()
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }

  Widget musicTitle() {
    return ValueListenableBuilder<ButtonState>(
      valueListenable: pageManager.playButtonNotifier,
      builder: (_, buttonState, __) {
        return Text(
          buttonState == ButtonState.paused ? 'Stopped' : 'Playing now',
          style: Theme.of(context).textTheme.headline6!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
        );
      },
    );
  }
}
