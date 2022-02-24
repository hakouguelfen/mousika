import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:music_play/components/music_card.dart';
import 'package:music_play/constants.dart';
import 'package:music_play/manager/page_manager.dart';
import 'package:music_play/services/service_locator.dart';
import 'package:rive/rive.dart';

class MusicImageCover extends StatefulWidget {
  const MusicImageCover({
    Key? key,
    required this.currentSong,
  }) : super(key: key);

  final MediaItem currentSong;

  @override
  State<MusicImageCover> createState() => _MusicImageCoverState();
}

class _MusicImageCoverState extends State<MusicImageCover> {
  final pageManager = getIt<PageManager>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Hero(
        tag: 'song${widget.currentSong.title}',
        // child: const RiveAnimation.asset(
        //   'assets/rive/musicPlayer.riv',
        //   fit: BoxFit.fill,
        // ),
        child: widget.currentSong.extras!['image'] == null
            ? const MusicCard(
                width: double.maxFinite,
                height: double.maxFinite,
                icon: Icons.music_note_rounded,
                size: 200,
                opacity: 1,
              )
            : musicImage(),
      ),
    );
  }

  Container musicImage() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: defaultPadding),
      width: double.maxFinite,
      height: double.maxFinite,
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/images/arcade.png'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(defaultBorderRaduis),
      ),
    );
  }
}
