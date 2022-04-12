import 'package:flutter/material.dart';

class PlayButton extends StatelessWidget {
  final VoidCallback press;
  final bool buttonState;
  const PlayButton({Key? key, required this.press, required this.buttonState})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      heroTag: null,
      onPressed: press,
      label: Text(
        buttonState ? 'Play' : 'Stop',
        style: Theme.of(context).textTheme.headline6!.copyWith(
              fontSize: 20,
              color: Theme.of(context).colorScheme.secondary,
            ),
      ),
      icon: musicStateIcon(buttonState),
      backgroundColor: Theme.of(context).cardColor,
      foregroundColor: Theme.of(context).colorScheme.secondary,
    );
  }

  Icon musicStateIcon(bool _buttonState) {
    return _buttonState
        ? const Icon(Icons.arrow_right_rounded, size: 50)
        : const Icon(Icons.pause);
  }
}
