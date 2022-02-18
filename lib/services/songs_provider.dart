import 'package:audio_service/audio_service.dart';
import 'package:ness_audio_metadata/ness_audio_metadata.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:core';

class Songs {
  final parser = MetaAudio();
  List<MediaItem> playList = [];

  // retreive the root of device fileSystem
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

  // Retreive all songs in the device fileSystem
  Future getSongs() async {
    String _rootFileSystem = await _getRootFileSystem();
    List titles = [];
    List indexs = [];

    await travarseDeviceStorage(Directory(_rootFileSystem).listSync());

    playList.asMap().forEach((index, song) {
      !titles.contains(song.title) ? titles.add(song.title) : indexs.add(index);
    });

    int i = 0;
    for (var index in indexs) {
      playList.removeAt(index - i);
      i++;
    }

    return playList;
  }

  travarseDeviceStorage(List folders) async {
    List _songs = [];

    if (folders.isEmpty) {
      return _songs;
    }

    Directory currentFolder = folders.removeLast();

    for (FileSystemEntity file in currentFolder.listSync()) {
      // if (file is File) {}
      if (file.path.endsWith('.mp3')) {
        final metadata = await parser.parse(file.path);
        final artwork = await metadata?.artwork;

        _songs.add(
          MediaItem(
            id: metadata?.path ?? '',
            title: metadata?.title ??
                file.path.split('/').last.replaceAll('.mp3', ''),
            artist: metadata?.artist ?? 'Unknow',
            album: metadata?.album ?? '',
            extras: {'image': artwork!.exists ? artwork.data() : null},
          ),
        );
      }
    }

    await travarseDeviceStorage(folders);
    for (var song in _songs) {
      playList.add(song);
    }
  }
}
