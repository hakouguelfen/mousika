import 'dart:typed_data';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:music_play/components/music_round_card.dart';
import 'package:music_play/constants.dart';
import 'package:music_play/manager/page_manager.dart';
import 'package:music_play/notifiers/progressbar_notifier.dart';
import 'package:music_play/services/service_locator.dart';

import 'music_slider.dart';

class MusicImageCover extends StatelessWidget {
  const MusicImageCover({super.key, required this.title, required this.image});

  final String title;
  final Uint8List? image;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'song$title',
      child: Stack(
        children: [
          image == null ? const RoundedMusicCard() : musicImage(context),
          const MusicSlider(),
        ],
      ),
    );
  }

  Stack musicImage(context) {
    final pageManager = getIt<PageManager>();

    double width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Container(
          width: double.maxFinite,
          height: double.maxFinite,
          padding: const EdgeInsets.all(defaultPadding),
          child: CircleAvatar(
            backgroundImage: MemoryImage(image!),
            backgroundColor: Theme.of(context).cardColor,
          ),
        ),
        ValueListenableBuilder<ProgressBarState>(
          valueListenable: pageManager.progressNotifier,
          builder: (_, progressVal, __) {
            final double current = progressVal.current.inSeconds.toDouble();
            final double total = progressVal.total.inSeconds.toDouble();
            final double psongProgess =
                current * (width - defaultPadding) / total;

            return AnimatedContainer(
              constraints: const BoxConstraints(
                maxWidth: double.maxFinite,
                minWidth: 0.0,
              ),
              margin: EdgeInsets.all(
                psongProgess < defaultPadding
                    ? defaultPadding
                    : psongProgess * math.sin(psongProgess) + psongProgess,
              ),
              duration: const Duration(seconds: 1),
              curve: Curves.easeInOutCubic,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(.5),
                shape: BoxShape.circle,
              ),
            );
          },
        ),
      ],
    );
  }
}
