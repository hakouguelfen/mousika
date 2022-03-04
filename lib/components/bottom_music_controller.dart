import 'package:flutter/material.dart';

import '../constants.dart';

class BottomMusicController extends StatelessWidget {
  const BottomMusicController({Key? key}) : super(key: key);

  Container musicImage() {
    return Container(
      width: 80,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/icons/logo.png'),
          fit: BoxFit.fill,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Container(
      width: double.maxFinite,
      height: height * 0.08,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Hero(
                  tag: 'songColor',
                  transitionOnUserGestures: true,
                  createRectTween: (begin, end) {
                    return MaterialRectCenterArcTween(begin: begin, end: end);
                  },
                  child: musicImage(),
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
                        'Color out music',
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontSize: 18,
                            ),
                      ),
                      SizedBox(height: height * 0.01),
                      Text(
                        'The Beatles',
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
                    Icons.favorite_outline_rounded,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Icon(
                    Icons.play_arrow_rounded,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.maxFinite,
            height: 2,
            padding:
                const EdgeInsets.symmetric(horizontal: defaultPadding * 0.2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: const LinearProgressIndicator(
              value: 50,
              backgroundColor: Colors.red,
              semanticsLabel: 'progess',
            ),
          ),
        ],
      ),
    );
  }
}
