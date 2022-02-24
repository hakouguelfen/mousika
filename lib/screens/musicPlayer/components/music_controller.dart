// import 'package:audio_service/audio_service.dart';
// import 'package:flutter/material.dart';
// import 'package:music_play/manager/page_manager.dart';
// import 'package:music_play/notifiers/play_button_notifier.dart';
// import 'package:music_play/services/service_locator.dart';

// import 'music_play_button.dart';
// import 'music_slider.dart';

// class MusicController extends StatefulWidget {
//   const MusicController({
//     Key? key,
//     required this.isCurrentSong,
//     required this.currentSong,
//   }) : super(key: key);
//   bool isCurrentSong;
//   final MediaItem currentSong;

//   @override
//   _MusicControllerState createState() => _MusicControllerState();
// }

// class _MusicControllerState extends State<MusicController> {
//   final pageManager = getIt<PageManager>();

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         // First Row
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Expanded(
//               flex: 2,
//               child: ValueListenableBuilder<ButtonState>(
//                   valueListenable: pageManager.playButtonNotifier,
//                   builder: (_, buttonState, __) {
//                     return widget.isCurrentSong
//                         ? PlayButton(
//                             press: () {
//                               buttonState == ButtonState.paused
//                                   ? pageManager.play()
//                                   : pageManager.pause();
//                             },
//                             buttonState: buttonState == ButtonState.paused ||
//                                 buttonState == ButtonState.loading,
//                           )
//                         : PlayButton(
//                             press: () {
//                               setState(() {
//                                 widget.isCurrentSong = !widget.isCurrentSong;
//                                 pageManager
//                                     .playSpecificSong(widget.currentSong);
//                                 pageManager.play();
//                               });
//                             },
//                             buttonState: true,
//                           );
//                   }),
//             ),
//             Expanded(
//               flex: 1,
//               child: FloatingActionButton.large(
//                 onPressed: () => pageManager.next(),
//                 child: Icon(
//                   Icons.skip_next_rounded,
//                   size: Theme.of(context).iconTheme.size,
//                 ),
//                 elevation: 0,
//               ),
//             ),
//           ],
//         ),
//         // Second Row
//         const SizedBox(height: 15),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             FloatingActionButton.large(
//               onPressed: () => pageManager.previous(),
//               child: Icon(
//                 Icons.skip_previous_rounded,
//                 size: Theme.of(context).iconTheme.size,
//               ),
//               elevation: 0,
//             ),
//             Expanded(
//               child: MusicSlider(isCurrentSong: widget.isCurrentSong),
//             ),
//           ],
//         )
//       ],
//     );
//   }
// }
