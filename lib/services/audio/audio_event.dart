part of 'audio_bloc.dart';

abstract class AudioEvent extends Equatable {
  const AudioEvent();

  @override
  List<Object> get props => [];
}

class InitializePlayer extends AudioEvent {}

class LoadAudio extends AudioEvent {
  final String filePath;

  const LoadAudio({required this.filePath});

  @override
  List<Object> get props => [filePath];
}

class PlayAudio extends AudioEvent {}

class AudioIsCompleted extends AudioEvent {}

class PauseAudio extends AudioEvent {}

class SeekAudio extends AudioEvent {
  final double position;

  const SeekAudio({required this.position});

  @override
  List<Object> get props => [position];
}

class AudioIsProgressing extends AudioEvent {
  final Duration position;

  const AudioIsProgressing({required this.position});

  @override
  List<Object> get props => [position];
}

class DurationChanged extends AudioEvent {
  final Duration length;

  const DurationChanged({required this.length});

  @override
  List<Object> get props => [length];
}

class SendAudio extends AudioEvent {
  final String voiceId;

  const SendAudio({required this.voiceId});

  @override
  List<Object> get props => [voiceId];
}
