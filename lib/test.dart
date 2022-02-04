import 'package:flutter/material.dart';
import 'package:music_play/constants.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  bool selected = false;
  double val = 100;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.maxFinite,
          height: height * 0.1,
          padding: const EdgeInsets.only(right: defaultPadding),
          margin: const EdgeInsets.symmetric(vertical: defaultPadding * 0.1),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              AnimatedPositioned(
                width: val,
                height: 350,
                top: 0,
                duration: const Duration(seconds: 2),
                curve: Curves.fastOutSlowIn,
                child: Container(
                  color: Theme.of(context)
                      .scaffoldBackgroundColor
                      .withOpacity(0.4),
                  child: const Center(child: Text('Tap me')),
                ),
              ),
              SizedBox(
                width: double.maxFinite,
                height: 100,
                child: Row(
                  children: [
                    Container(
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
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
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
                            'title',
                            style:
                                Theme.of(context).textTheme.headline6!.copyWith(
                                      fontSize: 18,
                                    ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'artist',
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
            ],
          ),
        ),
      ),
    );
  }
}
