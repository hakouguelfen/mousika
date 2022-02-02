import 'package:flutter/material.dart';

class PlayButton extends StatelessWidget {
  final VoidCallback press;
  final bool buttonState;
  const PlayButton({Key? key, required this.press, required this.buttonState})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: press,
      child: musicStateIcon(buttonState),
      backgroundColor: Theme.of(context).colorScheme.primary,
    );
  }

  Icon musicStateIcon(bool _buttonState) {
    return _buttonState
        ? const Icon(Icons.arrow_right_rounded, size: 40)
        : const Icon(Icons.pause);
  }
}
