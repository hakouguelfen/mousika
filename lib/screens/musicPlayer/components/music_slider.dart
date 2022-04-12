import 'package:flutter/material.dart';
import 'package:music_play/constants.dart';
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

  String _getTimeString(Duration time) {
    final minutes =
        time.inMinutes.remainder(Duration.minutesPerHour).toString();
    final seconds = time.inSeconds
        .remainder(Duration.secondsPerMinute)
        .toString()
        .padLeft(2, '0');
    return time.inHours > 0
        ? "${time.inHours}:${minutes.padLeft(2, "0")}:$seconds"
        : "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ProgressBarState>(
      valueListenable: pageManager.progressNotifier,
      builder: (_, dynamic progressVal, __) {
        return Column(
          children: [
            Slider(
              min: 0.0,
              value: progressVal.current.inSeconds.toDouble(),
              max: progressVal.total.inSeconds.toDouble(),
              onChanged: (double value) {
                setState(() {
                  Duration position = Duration(seconds: value.toInt());
                  pageManager.seek(position);
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _getTimeString(progressVal.current),
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                Text(
                  _getTimeString(progressVal.total),
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
