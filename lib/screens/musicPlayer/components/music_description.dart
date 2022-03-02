import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:music_play/constants.dart';

class MusicDescription extends StatelessWidget {
  const MusicDescription({
    Key? key,
    required this.currentSong,
  }) : super(key: key);
  final MediaItem currentSong;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SingleChildScrollView(
          child: Text(
            currentSong.title,
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
            softWrap: true,
          ),
          scrollDirection: Axis.horizontal,
        ),
        const SizedBox(height: defaultPadding),
        SingleChildScrollView(
          child: Text(
            currentSong.artist ?? '',
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w100,
                ),
            textAlign: TextAlign.center,
          ),
          scrollDirection: Axis.horizontal,
        ),
      ],
    );
  }
}
