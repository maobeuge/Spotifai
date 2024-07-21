part of 'recorder_bloc.dart';

abstract class RecorderState extends Equatable {
  const RecorderState();

  @override
  List<Object> get props => [];
}

class RecorderInitial extends RecorderState {}

class RecorderLoaded extends RecorderState {}

class RecorderRecording extends RecorderState {}

class AudioRecorded extends RecorderState {
  final String filePath;

  const AudioRecorded({required this.filePath});

  @override
  List<Object> get props => [filePath];
}
