import 'package:flutter/material.dart';
import 'package:music_play/constants.dart';

class MusicCard extends StatelessWidget {
  const MusicCard({
    Key? key,
    required this.width,
    required this.size,
    required this.opacity,
    required this.height,
    required this.icon,
  }) : super(key: key);

  final double width;
  final double height;
  final double size;
  final double opacity;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: double.maxFinite,
      child: Icon(
        icon,
        color: Colors.blueAccent,
        size: size,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withOpacity(opacity),
        borderRadius:
            const BorderRadius.all(Radius.circular(defaultBorderRaduis)),
      ),
    );
  }
}
