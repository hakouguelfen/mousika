import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:music_play/constants.dart';
import 'package:music_play/screens/musicPlayer/music_player.dart';

class MusicContainer extends StatelessWidget {
  final MediaItem songMetaData;
  const MusicContainer({Key? key, required this.songMetaData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 700),
              pageBuilder: (context, animation, _) => MusicPlayer(
                    songMetaData: songMetaData,
                  )),
        );
      },
      child: Container(
        width: double.maxFinite,
        height: height * 0.1,
        padding: const EdgeInsets.only(right: defaultPadding),
        margin: const EdgeInsets.symmetric(vertical: defaultPadding * 0.1),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Hero(
              tag: 'song${songMetaData.title}',
              transitionOnUserGestures: true,
              createRectTween: (begin, end) {
                return MaterialRectCenterArcTween(begin: begin, end: end);
              },
              child: Container(
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
              ),
            ),
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
              fit: FlexFit.loose,
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
}
