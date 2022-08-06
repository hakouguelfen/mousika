import 'package:flutter/material.dart';
import 'package:mousika/config/config.dart';
import 'package:mousika/manager/page_manager.dart';

import 'package:mousika/services/service_locator.dart';

class RoundedMusicCard extends StatelessWidget {
  const RoundedMusicCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();

    double width = MediaQuery.of(context).size.width;
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      padding: const EdgeInsets.all(Sizes.defaultPadding),
      child: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(
          Icons.music_note_rounded,
          size: 200,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}
