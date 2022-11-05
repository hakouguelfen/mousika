import 'package:flutter/material.dart';
import 'package:mousika/config/config.dart';

class RoundedMusicCard extends StatelessWidget {
  const RoundedMusicCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      padding: const EdgeInsets.all(Sizes.defaultPadding),
      child: CircleAvatar(
        backgroundColor: Theme.of(context).cardColor,
        child: Icon(
          Icons.music_note_rounded,
          size: 200,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}
