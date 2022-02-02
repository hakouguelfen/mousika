import 'package:audio_service/audio_service.dart';
import 'package:music_play/notifiers/play_button_notifier.dart';
import 'package:music_play/notifiers/progressbar_notifier.dart';
import 'package:music_play/services/songs_provider.dart';
import 'package:music_play/services/service_locator.dart';

import 'package:flutter/foundation.dart';

class PageManager {
  final _audioHandler = getIt<AudioHandler>();

  // Listeners: Updates going to the UI
  final currentSongNotifier =
      ValueNotifier<MediaItem>(const MediaItem(id: '', title: ''));
  final playlistNotifier = ValueNotifier<List<MediaItem>>([]);
  final progressNotifier = ProgressNotifier();
  // final repeatButtonNotifier = RepeatButtonNotifier();
  final isFirstSongNotifier = ValueNotifier<bool>(true);
  final playButtonNotifier = PlayButtonNotifier();
  final isLastSongNotifier = ValueNotifier<bool>(true);
  // final isShuffleModeEnabledNotifier = ValueNotifier<bool>(false);

  // Events: Calls coming from the UI
  void init() async {
    await _loadPlaylist();
    _listenToChangesInPlaylist();
    _listenToPlaybackState();
    _listenToCurrentPosition();
    _listenToBufferedPosition();
    _listenToTotalDuration();
  }

  Future<void> _loadPlaylist() async {
    final songRepository = getIt<Songs>();
    final playlist = await songRepository.getSongs();
    _audioHandler.addQueueItems(playlist);
  }

  void _listenToChangesInPlaylist() {
    _audioHandler.queue.listen((playlist) {
      if (playlist.isEmpty) return;
      playlistNotifier.value = playlist;
    });
  }

  _listenToPlaybackState() {
    _audioHandler.playbackState.listen((playbackState) {
      final isPlaying = playbackState.playing;
      final processingState = playbackState.processingState;

      if (processingState == AudioProcessingState.loading ||
          processingState == AudioProcessingState.buffering) {
        playButtonNotifier.value = ButtonState.loading;
        return;
      }

      if (!isPlaying) {
        playButtonNotifier.value = ButtonState.paused;
        return;
      }

      if (processingState != AudioProcessingState.completed) {
        playButtonNotifier.value = ButtonState.playing;
        return;
      }
      _audioHandler.seek(Duration.zero);
      _audioHandler.pause();
    });
  }

  void _listenToCurrentPosition() {
    AudioService.position.listen((position) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: position,
        buffered: oldState.buffered,
        total: oldState.total,
      );
    });
  }

  void _listenToBufferedPosition() {
    _audioHandler.playbackState.listen((playbackState) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: playbackState.bufferedPosition,
        total: oldState.total,
      );
    });
  }

  void _listenToTotalDuration() {
    _audioHandler.mediaItem.listen((mediaItem) {
      currentSongNotifier.value =
          mediaItem ?? const MediaItem(id: '', title: '');
      _updateSkipButtons();

      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: oldState.buffered,
        total: mediaItem?.duration ?? Duration.zero,
      );
    });
  }

  void _updateSkipButtons() {
    final mediaItem = _audioHandler.mediaItem.value;
    final playlist = _audioHandler.queue.value;
    if (playlist.length < 2 || mediaItem == null) {
      isFirstSongNotifier.value = true;
      isLastSongNotifier.value = true;
    } else {
      isFirstSongNotifier.value = playlist.first == mediaItem;
      isLastSongNotifier.value = playlist.last == mediaItem;
    }
  }

  void play() => _audioHandler.play();
  void pause() => _audioHandler.pause();
  void seek(Duration position) => _audioHandler.seek(position);
  void previous() => _audioHandler.skipToPrevious();
  void next() => _audioHandler.skipToNext();
  void repeat() {}
  void shuffle() {}

  void playSpecificSong(MediaItem _item) {
    final _currentSong = _audioHandler.mediaItem.value;
    if (_currentSong == _item) return;

    final _playlist = _audioHandler.queue.value;
    final _songIndex = _playlist.indexWhere((song) => song == _item);

    _audioHandler.skipToQueueItem(_songIndex);
  }

  void remove() {}
  void dispose() {
    _audioHandler.stop();
  }

  void stop() {}
}
