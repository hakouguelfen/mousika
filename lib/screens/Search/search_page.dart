import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:music_play/components/music_container.dart';
import 'package:music_play/constants.dart';
import 'package:music_play/manager/page_manager.dart';
import 'package:music_play/services/service_locator.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searchVal = '';
  final pageManager = getIt<PageManager>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              searchTextField(context),
              const SizedBox(height: 20),
              ValueListenableBuilder<List<MediaItem>>(
                valueListenable: pageManager.playlistNotifier,
                builder: (_, playList, __) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: playList.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (playList[index]
                                .title
                                .toLowerCase()
                                .contains(searchVal) ||
                            playList[index]
                                .artist!
                                .toLowerCase()
                                .contains(searchVal)) {
                          return MusicContainer(
                            currentSong: playList[index],
                            gotoNextPage: true,
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextField searchTextField(BuildContext context) {
    return TextField(
      onChanged: (val) => setState(() => searchVal = val),
      textInputAction: TextInputAction.search,
      keyboardType: TextInputType.text,
      autofocus: true,
      cursorColor: blue3,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(defaultBorderRaduis),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(defaultBorderRaduis),
          ),
        ),
        prefixIcon: const Icon(
          Icons.search,
          color: blue3,
        ),
        filled: true,
        fillColor: Theme.of(context).cardColor,
        hintText: 'Search for songs, artists ...',
      ),
    );
  }
}
