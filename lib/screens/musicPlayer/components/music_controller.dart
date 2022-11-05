import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mousika/manager/page_manager.dart';
import 'package:mousika/notifiers/play_button_notifier.dart';
import 'package:mousika/services/service_locator.dart';

import 'music_play_button.dart';

class MusicController extends ConsumerWidget {
  const MusicController({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageManager = getIt<PageManager>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FloatingActionButton.large(
          onPressed: () => pageManager.previous(),
          heroTag: null,
          elevation: 0,
          child: Icon(
            Icons.skip_previous_rounded,
            size: Theme.of(context).iconTheme.size,
          ),
        ),
        ValueListenableBuilder<ButtonState>(
          valueListenable: pageManager.playButtonNotifier,
          builder: (_, buttonState, __) {
            return PlayButton(
              press: () {
                // ButtonState state = ref.watch(productSortTypeProvider);
                // print(state);
                buttonState == ButtonState.paused
                    ? pageManager.play()
                    : pageManager.pause();
              },
              buttonState: buttonState == ButtonState.paused,
            );
          },
        ),
        FloatingActionButton.large(
          heroTag: null,
          onPressed: () => pageManager.next(),
          elevation: 0,
          child: Icon(
            Icons.skip_next_rounded,
            size: Theme.of(context).iconTheme.size,
          ),
        ),
      ],
    );
  }
}
