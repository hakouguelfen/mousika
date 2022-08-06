import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:mousika/config/config.dart';

class MusicDescription extends StatelessWidget {
  final MediaItem currentSong;
  const MusicDescription({super.key, required this.currentSong});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(
            textAlign: TextAlign.center,
            softWrap: true,
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
            currentSong.title,
          ),
        ),
        const SizedBox(height: Sizes.defaultPadding),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(
            currentSong.artist ?? '',
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w100,
                ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
