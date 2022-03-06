import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:music_play/components/music_round_card.dart';

class MusicImageCover extends StatelessWidget {
  const MusicImageCover({Key? key, required this.title, required this.image})
      : super(key: key);

  final String title;
  final Uint8List? image;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'song$title',
      child: image == null ? const RoundedMusicCard() : musicImage(context),
    );
  }

  SizedBox musicImage(context) {
    return SizedBox(
      width: double.maxFinite,
      height: double.maxFinite,
      child: CircleAvatar(
        backgroundImage: MemoryImage(image!),
        backgroundColor: Theme.of(context).cardColor,
      ),
    );
  }
}
