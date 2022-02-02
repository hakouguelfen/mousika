import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:music_play/constants.dart';
import 'package:music_play/manager/page_manager.dart';
import 'package:music_play/services/service_locator.dart';

class MusicImageCover extends StatefulWidget {
  const MusicImageCover({
    Key? key,
  }) : super(key: key);

  @override
  State<MusicImageCover> createState() => _MusicImageCoverState();
}

class _MusicImageCoverState extends State<MusicImageCover> {
  final pageManager = getIt<PageManager>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: TweenAnimationBuilder(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          width: double.maxFinite,
          height: double.maxFinite,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(defaultPadding),
            child: ValueListenableBuilder<MediaItem>(
              valueListenable: pageManager.currentSongNotifier,
              builder: (_, song, __) {
                return Hero(
                  tag: 'song${song.title}',
                  transitionOnUserGestures: true,
                  child: const Image(
                    image: AssetImage('assets/images/arcade.png'),
                    fit: BoxFit.fill,
                  ),
                );
              },
            ),
          ),
        ),
        duration: const Duration(seconds: 10),
        tween: ColorTween(begin: Colors.grey, end: Colors.white),
        builder: (_, Color? color, _child) {
          return ColorFiltered(
            child: _child,
            colorFilter: ColorFilter.mode(color!, BlendMode.modulate),
          );
        },
      ),
    );
  }
}
