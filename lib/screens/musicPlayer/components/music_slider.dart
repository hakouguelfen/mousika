import 'package:flutter/material.dart';
import 'package:music_play/manager/page_manager.dart';
import 'package:music_play/notifiers/progressbar_notifier.dart';
import 'package:music_play/services/service_locator.dart';

class MusicSlider extends StatefulWidget {
  const MusicSlider({Key? key, required this.currentSong}) : super(key: key);
  final bool currentSong;

  @override
  State<MusicSlider> createState() => _MusicSliderState();
}

class _MusicSliderState extends State<MusicSlider> {
  final pageManager = getIt<PageManager>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder<ProgressBarState>(
        valueListenable: pageManager.progressNotifier,
        builder: (_, dynamic progressVal, __) {
          return widget.currentSong
              ? sliderProgress(
                  context,
                  progressVal.current.inSeconds.toDouble(),
                  progressVal.total.inSeconds.toDouble(),
                  (double value) {
                    setState(() {
                      Duration position = Duration(seconds: value.toInt());
                      pageManager.seek(position);
                    });
                  },
                )
              : sliderProgress(
                  context,
                  0.0,
                  0.0,
                  (double val) {},
                );
        },
      ),
    );
  }
}

Slider sliderProgress(BuildContext context, current, maxVal, changeSlideVal) {
  return Slider(
    min: 0.0,
    value: current,
    max: maxVal,
    onChanged: changeSlideVal,
    activeColor: Theme.of(context).colorScheme.primary,
    inactiveColor: Theme.of(context).cardColor,
    thumbColor: Theme.of(context).colorScheme.primary,
  );
}
