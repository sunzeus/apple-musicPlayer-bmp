import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

import 'read_index.dart';
import 'save_index.dart';

// Class for handling audio playback using AudioService and Just Audio
class SongHandler extends BaseAudioHandler with QueueHandler, SeekHandler {
  // Create an instance of the AudioPlayer class from just_audio package
  final AudioPlayer audioPlayer = AudioPlayer();

  // Function to create an audio source from a MediaItem
  UriAudioSource _createAudioSource(MediaItem item) {
    return ProgressiveAudioSource(Uri.parse(item.id));
  }

  // Listen for changes in the current song index and update the media item
  void _listenForCurrentSongIndexChanges() {
    audioPlayer.currentIndexStream.listen((index) {
      if (index != null) {
        saveIndex(index);
      }
      final playlist = queue.value;
      if (index == null || playlist.isEmpty) return;
      mediaItem.add(playlist[index]);
    });
  }

  // Broadcast the current playback state based on the received PlaybackEvent
  void _broadcastState(PlaybackEvent event) {
    playbackState.add(playbackState.value.copyWith(
      controls: [
        MediaControl.skipToPrevious,
        if (audioPlayer.playing) MediaControl.pause else MediaControl.play,
        MediaControl.skipToNext,
      ],
      systemActions: {
        MediaAction.seek,
        MediaAction.seekForward,
        MediaAction.seekBackward,
      },
      processingState: const {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[audioPlayer.processingState]!,
      playing: audioPlayer.playing,
      updatePosition: audioPlayer.position,
      bufferedPosition: audioPlayer.bufferedPosition,
      speed: audioPlayer.speed,
      queueIndex: event.currentIndex,
    ));
  }

  // Function to initialize the songs and set up the audio player
  Future<void> initSongs({required List<MediaItem> songs}) async {
    // Listen for playback events and broadcast the state
    audioPlayer.playbackEventStream.listen(_broadcastState);

    // Create a list of audio sources from the provided songs
    final audioSource = songs.map(_createAudioSource).toList();

    // Set the audio source of the audio player to the concatenation of the audio sources
    await audioPlayer
        .setAudioSource(ConcatenatingAudioSource(children: audioSource));

    // Add the songs to the queue
    queue.value.clear();
    queue.value.addAll(songs);
    queue.add(queue.value);

    await readIndex().then(
      (value) async {
        if (value != null) {
          await skipToQueueItem(value);
          await pause();
        }
      },
    );

    // Listen for changes in the current song index
    _listenForCurrentSongIndexChanges();

    // Listen for processing state changes and skip to the next song when completed
    audioPlayer.processingStateStream.listen((state) {
      if (state == ProcessingState.completed) skipToNext();
    });
  }

  // Play function to start playback
  @override
  Future<void> play() => audioPlayer.play();

  // Pause function to pause playback
  @override
  Future<void> pause() => audioPlayer.pause();

  // Seek function to change the playback position
  @override
  Future<void> seek(Duration position) => audioPlayer.seek(position);

  // Skip to a specific item in the queue and start playback
  @override
  Future<void> skipToQueueItem(int index) async {
    await audioPlayer.seek(Duration.zero, index: index);
    play();
  }

  // Skip to the next item in the queue
  @override
  Future<void> skipToNext() async => await audioPlayer.seekToNext();

  // Skip to the previous item in the queue
  @override
  Future<void> skipToPrevious() async => await audioPlayer.seekToPrevious();

  // Function to shuffle the queue
  Future<void> shuffleQueue() async {
    await audioPlayer.setShuffleModeEnabled(true);
    await audioPlayer.shuffle();
  }

  Future<void> unShuffleQueue() async {
    await audioPlayer.setShuffleModeEnabled(false);
  }

  // Function to toggle loop mode
  Future<void> toggleLoopMode(LoopMode loopMode) async {
    await audioPlayer.setLoopMode(loopMode);
  }

  @override
  Future<void> setSpeed(double speed) async {
    await audioPlayer.setSpeed(speed);
  }
}
