import 'package:audio_service/audio_service.dart';
import 'package:ness_audio_metadata/ness_audio_metadata.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:core';

class Songs {
  final parser = MetaAudio();

  Future _getRootFileSystem() async {
    String _rootPath = '/';

    Directory? appDocDir = await getExternalStorageDirectory();
    List _folders = appDocDir!.path.split('/');

    for (var i = 1; i < _folders.length; i++) {
      String file = _folders[i];
      if (file == 'Android') {
        break;
      }
      _rootPath += '$file/';
    }
    return _rootPath;
  }

  Future getSongs() async {
    String _rootFileSystem = await _getRootFileSystem();
    List<MediaItem> _songs = [];

    Directory musicFolder = Directory(_rootFileSystem + 'Music/');

    for (var file in musicFolder.listSync()) {
      if (file.path.endsWith('.mp3')) {
        final metadata = await parser.parse(file.path);
        final artwork = await metadata?.artwork;

        _songs.add(
          MediaItem(
            id: metadata?.path ?? '',
            title: metadata?.title ?? '',
            artist: metadata?.artist ?? '',
            album: metadata?.album ?? '',
            extras: {'image': artwork!.exists ? artwork.data() : null},
          ),
        );
      }
    }

    return _songs;
  }
}
