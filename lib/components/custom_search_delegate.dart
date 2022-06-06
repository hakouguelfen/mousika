import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:music_play/manager/page_manager.dart';
import 'package:music_play/services/service_locator.dart';

import 'music_container.dart';

final pageManager = getIt<PageManager>();

class CustomSearchDelegate extends SearchDelegate {
  final List<MediaItem> songs = pageManager.playlistNotifier.value;

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.chevron_left_rounded),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView.builder(
      itemCount: songs.length,
      itemBuilder: (BuildContext context, int index) {
        if (songs[index].title.toLowerCase().contains(query) ||
            songs[index].artist!.toLowerCase().contains(query)) {
          return MusicContainer(
            currentSong: songs[index],
            gotoNextPage: true,
          );
        } else {
          return Container();
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.builder(
      itemCount: songs.length,
      itemBuilder: (BuildContext context, int index) {
        return MusicContainer(
          currentSong: songs[index],
          gotoNextPage: true,
        );
      },
    );
  }
}
