import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:music_play/manager/page_manager.dart';
import 'package:music_play/services/service_locator.dart';

class MusicDescription extends StatefulWidget {
  const MusicDescription({
    Key? key,
    required this.currentSong,
    required this.songMetaData,
  }) : super(key: key);

  final bool currentSong;
  final MediaItem songMetaData;
  @override
  State<MusicDescription> createState() => _MusicDescriptionState();
}

class _MusicDescriptionState extends State<MusicDescription> {
  final pageManager = getIt<PageManager>();
  bool isFavourite = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ValueListenableBuilder<MediaItem>(
            valueListenable: pageManager.currentSongNotifier,
            builder: (_, song, __) {
              return widget.currentSong
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          song.title,
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          song.artist ?? '',
                          style: TextStyle(
                            color: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .color!
                                .withOpacity(0.65),
                          ),
                        )
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.songMetaData.title,
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          widget.songMetaData.artist ?? '',
                          style: TextStyle(
                            color: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .color!
                                .withOpacity(0.65),
                          ),
                        ),
                      ],
                    );
            },
          ),
          InkWell(
            onTap: () => setState(() => isFavourite = !isFavourite),
            child: favouriteSongStateIcon(),
          ),
        ],
      ),
    );
  }

  Icon favouriteSongStateIcon() {
    return isFavourite
        ? const Icon(Icons.favorite_rounded, size: 30, color: Colors.green)
        : const Icon(Icons.favorite_outline, size: 30);
  }
}
