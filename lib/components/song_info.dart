import 'package:flutter/material.dart';

class SongInfo extends StatelessWidget {
  const SongInfo({
    Key? key,
    required this.title,
    required this.artist,
    required this.size,
    required this.fontSize,
  }) : super(key: key);
  final String title;
  final String artist;
  final double size;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline6!.copyWith(
                fontSize: fontSize,
              ),
        ),
        SizedBox(height: height * size),
        Text(
          artist,
          style: TextStyle(
            color:
                Theme.of(context).textTheme.bodyText2!.color!.withOpacity(0.75),
          ),
        ),
      ],
    );
  }
}
