import 'package:flutter/material.dart';
import 'package:music_play/manager/page_manager.dart';
import 'package:music_play/notifiers/progressbar_notifier.dart';
import 'package:music_play/services/service_locator.dart';

class MusicSlider extends StatefulWidget {
  const MusicSlider({Key? key}) : super(key: key);

  @override
  State<MusicSlider> createState() => _MusicSliderState();
}

class _MusicSliderState extends State<MusicSlider> {
  final pageManager = getIt<PageManager>();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ProgressBarState>(
      valueListenable: pageManager.progressNotifier,
      builder: (_, dynamic progressVal, __) {
        return Slider(
          min: 0.0,
          value: progressVal.current.inSeconds.toDouble(),
          max: progressVal.total.inSeconds.toDouble(),
          onChanged: (double value) {
            setState(() {
              Duration position = Duration(seconds: value.toInt());
              pageManager.seek(position);
            });
          },
        );
      },
    );
  }
}
