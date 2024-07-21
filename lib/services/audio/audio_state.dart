part of 'audio_bloc.dart';

abstract class AudioState extends Equatable {
  const AudioState();

  @override
  List<Object> get props => [];
}

class AudioInitial extends AudioState {}

class NoAudioLoaded extends AudioState {}

class AudioLoaded extends AudioState {
  final bool isAudioEmpty;
  final bool isPlaying;
  final Duration position;
  final Duration duration;
  final String filePath;

  const AudioLoaded({
    required this.isAudioEmpty,
    required this.isPlaying,
    required this.position,
    required this.duration,
    required this.filePath,
  });

  @override
  List<Object> get props => [isAudioEmpty, isPlaying, position, filePath];
}

class AudioSent extends AudioState {
  final bool isAudioEmpty;
  final bool isPlaying;
  final Duration position;
  final Duration duration;
  final String filePath;
  final int progression;

  const AudioSent(
      {required this.isAudioEmpty,
      required this.isPlaying,
      required this.position,
      required this.duration,
      required this.filePath,
      required this.progression});

  @override
  List<Object> get props => [
        isAudioEmpty,
        isPlaying,
        position,
        filePath,
        progression,
      ];
}
