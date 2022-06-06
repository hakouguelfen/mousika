import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:music_play/components/music_card.dart';
import 'package:music_play/constants.dart';
import 'package:music_play/screens/musicPlayer/music_player.dart';
import 'package:music_play/services/goto.dart';

import '../manager/page_manager.dart';
import '../services/service_locator.dart';

class MusicContainer extends StatelessWidget {
  final MediaItem currentSong;
  final bool gotoNextPage;
  const MusicContainer({
    Key? key,
    required this.currentSong,
    required this.gotoNextPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();

    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        pageManager.playSpecificSong(currentSong);
        pageManager.play();

        if (gotoNextPage) {
          // hide keyboard programaticlly first to avoid renderflex error
          FocusScope.of(context).unfocus();
          goto(context, MusicPlayer(currentSong: currentSong));
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: defaultPadding * 0.1,
          horizontal: defaultPadding * 0.5,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ValueListenableBuilder<MediaItem>(
          valueListenable: pageManager.currentSongNotifier,
          builder: (_, song, __) {
            return ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: defaultPadding * 0.5,
              ),
              leading: currentSong.extras!['image'] == null
                  ? const MusicCard(
                      width: 80,
                      height: double.maxFinite,
                      icon: Icons.music_note_rounded,
                      size: 40,
                      opacity: 0.0,
                    )
                  : musicImage(currentSong.extras!['image']),
              title: Text(
                currentSong.title,
                style: TextStyle(
                  color: song == currentSong
                      ? Theme.of(context).colorScheme.primaryContainer
                      : Theme.of(context).textTheme.bodyText2!.color!,
                ),
              ),
              subtitle: Text(
                currentSong.artist ?? "",
                style: TextStyle(
                  color: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .color!
                      .withOpacity(0.75),
                ),
              ),
              trailing: PopupMenuButton(
                itemBuilder: (context) => const [
                  PopupMenuItem(
                    child: ListTile(
                      leading: Icon(Icons.edit),
                      title: Text('edit'),
                    ),
                  ),
                  PopupMenuItem(
                    child: ListTile(
                      leading: Icon(Icons.delete),
                      title: Text('delete'),
                    ),
                  ),
                ],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(defaultBorderRaduis),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Container musicImage(image) {
    return Container(
      width: 70,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: MemoryImage(image),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(defaultPadding * 0.5),
      ),
    );
  }
}
