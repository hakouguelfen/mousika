import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:music_play/constants.dart';

class MusicImageCover extends StatefulWidget {
  const MusicImageCover({
    Key? key,
    required this.songMetaData,
  }) : super(key: key);

  final MediaItem songMetaData;

  @override
  State<MusicImageCover> createState() => _MusicImageCoverState();
}

class _MusicImageCoverState extends State<MusicImageCover> {
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
            child: Hero(
              tag: 'song${widget.songMetaData.title}',
              transitionOnUserGestures: true,
              child: const Image(
                image: AssetImage('assets/images/arcade.png'),
                fit: BoxFit.fill,
              ),
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
