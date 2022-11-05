import 'package:flutter/material.dart';

class PlayButton extends StatelessWidget {
  final VoidCallback press;
  final bool buttonState;
  const PlayButton({super.key, required this.press, required this.buttonState});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      heroTag: null,
      onPressed: press,
      label: const Text(""),
      icon: musicStateIcon(buttonState),
    );
  }

  Icon musicStateIcon(bool buttonState) {
    return buttonState
        ? const Icon(Icons.arrow_right_rounded, size: 70)
        : const Icon(Icons.pause, size: 50);
  }
}
