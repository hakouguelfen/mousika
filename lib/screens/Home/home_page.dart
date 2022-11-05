import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:mousika/components/bottom_music_controller.dart';
import 'package:mousika/components/custom_search_delegate.dart';
import 'package:mousika/config/config.dart';
import 'package:mousika/manager/page_manager.dart';
import 'package:mousika/screens/Home/all_songs.dart';
import 'package:mousika/services/service_locator.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();

    return Scaffold(
      appBar: buildAppBar(context),
      body: const SafeArea(
        child: AllSongs(),
      ),
      bottomNavigationBar: ValueListenableBuilder<MediaItem>(
        valueListenable: pageManager.currentSongNotifier,
        builder: (_, song, __) {
          return BottomMusicController(currentSong: song);
        },
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        'Mousika',
        style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 18),
      ),
      leading: const Padding(
        padding: EdgeInsets.all(Sizes.defaultPadding * 0.5),
        child: Image(image: AssetImage('assets/icons/logo.png')),
      ),
      actions: [
        IconButton(
          onPressed: () => showSearch(
            context: context,
            delegate: CustomSearchDelegate(),
          ),
          icon: const Icon(Icons.search_rounded),
        )
      ],
    );
  }
}
