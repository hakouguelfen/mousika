import 'package:flutter/material.dart';
import 'package:music_play/constants.dart';

class RoundedMusicCard extends StatelessWidget {
  const RoundedMusicCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      padding: const EdgeInsets.all(defaultPadding),
      child: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(
          Icons.music_note_rounded,
          size: 200,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}
