import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:music_play/components/music_round_card.dart';
import 'package:music_play/manager/page_manager.dart';
import 'package:music_play/services/service_locator.dart';

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
    return Hero(
      tag: 'song${widget.currentSong.title}',
      child: widget.currentSong.extras!['image'] == null
          ? const RoundedMusicCard()
          : musicImage(),
    );
  }

  SizedBox musicImage() {
    return SizedBox(
      width: double.maxFinite,
      height: double.maxFinite,
      child: CircleAvatar(
        backgroundImage: const AssetImage(
          'assets/images/arcade.png',
        ),
        backgroundColor: Theme.of(context).cardColor,
      ),
    );
  }
}
