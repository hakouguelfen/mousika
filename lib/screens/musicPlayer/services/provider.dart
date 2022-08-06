// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:mousika/manager/page_manager.dart';
// import 'package:mousika/notifiers/play_button_notifier.dart';
// import 'package:mousika/services/service_locator.dart';

// final productSortTypeProvider = StateProvider<ButtonState>((ref) {
//   final pageManager = getIt<PageManager>();

//   ButtonState state;
//   print('>>>>>>>>>>>>>>');

//   pageManager.playButtonNotifier.addListener(() {
//     state = pageManager.playButtonNotifier.value;
//   });

//   print(state);
//   return state!;
// });
