import 'package:flutter/material.dart';
import 'package:music_play/constants.dart';
import 'package:music_play/manager/page_manager.dart';
import 'package:music_play/notifiers/progressbar_notifier.dart';
import 'package:music_play/services/service_locator.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

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
        return SleekCircularSlider(
            appearance: CircularSliderAppearance(
              customWidths: CustomSliderWidths(
                progressBarWidth: 10,
                trackWidth: 10,
                shadowWidth: 10,
                handlerSize: 10,
              ),
              customColors: CustomSliderColors(
                progressBarColor: blue1,
                trackColor: Theme.of(context).cardColor,
                dotColor: blue2,
                shadowColor: blue1.withOpacity(0.2),
                shadowStep: 10,
              ),
              size: double.maxFinite,
            ),
            min: 0.0,
            initialValue: progressVal.current.inSeconds.toDouble(),
            max: progressVal.total.inSeconds.toDouble(),
            onChange: (double value) {
              setState(() {
                Duration position = Duration(seconds: value.toInt());
                pageManager.seek(position);
              });
            });
      },
    );
  }
}
