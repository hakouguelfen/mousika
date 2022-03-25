import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:music_play/components/music_card.dart';
import 'package:music_play/components/song_info.dart';
import 'package:music_play/constants.dart';
import 'package:music_play/screens/musicPlayer/music_player.dart';

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
    double height = MediaQuery.of(context).size.height;
    final pageManager = getIt<PageManager>();

    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        pageManager.playSpecificSong(currentSong);
        pageManager.play();

        if (gotoNextPage) {
          // hide keyboard programaticlly first to avoid renderflex error
          FocusScope.of(context).unfocus();
          Navigator.of(context).push(
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 700),
              pageBuilder: (context, animation, _) => MusicPlayer(
                currentSong: currentSong,
              ),
            ),
          );
        }
      },
      child: Container(
        width: double.maxFinite,
        height: height * 0.1,
        margin: const EdgeInsets.symmetric(vertical: defaultPadding * 0.1),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            currentSong.extras!['image'] == null
                ? const MusicCard(
                    width: 80,
                    height: double.maxFinite,
                    icon: Icons.music_note_rounded,
                    size: 40,
                    opacity: 0.0,
                  )
                : musicImage(currentSong.extras!['image']),
            // Hero(
            //   tag: 'song${currentSong.title}',
            //   transitionOnUserGestures: true,
            //   createRectTween: (begin, end) {
            //     return MaterialRectCenterArcTween(begin: begin, end: end);
            //   },
            //   child: currentSong.extras!['image'] == null
            //       ? const MusicCard(
            //           width: 80,
            //           height: double.maxFinite,
            //           icon: Icons.music_note_rounded,
            //           size: 40,
            //           opacity: 0.0,
            //         )
            //       : musicImage(currentSong.extras!['image']),
            // ),
            const SizedBox(width: defaultPadding * 0.7),
            Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: SongInfo(
                title: currentSong.title,
                artist: currentSong.artist ?? '',
                size: 0.01,
                fontSize: 18,
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Icon(
                Icons.more_vert_rounded,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container musicImage(image) {
    return Container(
      width: 80,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: MemoryImage(image),
          fit: BoxFit.cover,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
      ),
    );
  }
}
