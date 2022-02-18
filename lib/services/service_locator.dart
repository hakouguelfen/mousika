import 'package:audio_service/audio_service.dart';
import 'package:get_it/get_it.dart';
import 'package:music_play/manager/page_manager.dart';
import 'package:music_play/screens/musicPlayer/services/favourite_music_service.dart';
import 'package:music_play/services/songs_provider.dart';

import 'audio_handler.dart';

GetIt getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  getIt.registerSingleton<AudioHandler>(await initAudioService());
  getIt.registerLazySingleton<Songs>(() => Songs());
  getIt.registerLazySingleton<PageManager>(() => PageManager());
  getIt.registerLazySingleton<FavouriteSongs>(() => FavouriteSongs());
}
