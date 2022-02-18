import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:music_play/constants.dart';
import 'package:music_play/screens/musicPlayer/music_player.dart';

class MusicContainer extends StatelessWidget {
  final MediaItem songMetaData;
  final double containerWidth;
  const MusicContainer({
    Key? key,
    required this.songMetaData,
    required this.containerWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 700),
            pageBuilder: (context, animation, _) => MusicPlayer(
              songMetaData: songMetaData,
            ),
          ),
        );
      },
      child: Container(
        width: double.maxFinite,
        height: height * 0.1,
        margin: const EdgeInsets.symmetric(vertical: defaultPadding * 0.1),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            AnimatedContainer(
              constraints: const BoxConstraints(
                maxWidth: double.maxFinite,
                minWidth: 0.0,
              ),
              width: containerWidth,
              height: height * 0.1,
              duration: const Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
              color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.4),
            ),
            Row(
              children: [
                Hero(
                  tag: 'song${songMetaData.title}',
                  transitionOnUserGestures: true,
                  createRectTween: (begin, end) {
                    return MaterialRectCenterArcTween(begin: begin, end: end);
                  },
                  child: songMetaData.extras!['image'] == null
                      ? musicIcon()
                      : musicImage(),
                ),
                const SizedBox(width: defaultPadding * 0.7),
                Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        songMetaData.title,
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontSize: 18,
                            ),
                      ),
                      SizedBox(height: height * 0.01),
                      Text(
                        songMetaData.artist ?? '',
                        style: TextStyle(
                          color: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .color!
                              .withOpacity(0.65),
                        ),
                      ),
                    ],
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
          ],
        ),
      ),
    );
  }

  Container musicIcon() {
    return Container(
      width: 80,
      height: double.maxFinite,
      child: const Icon(
        Icons.music_note_rounded,
        color: Colors.blueAccent,
        size: 40,
      ),
      decoration: const BoxDecoration(
        // color: Theme.of(context)
        //     .scaffoldBackgroundColor
        //     .withOpacity(0.4),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
      ),
    );
  }

  Container musicImage() {
    return Container(
      width: 80,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/arcade.png'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
      ),
    );
  }
}
