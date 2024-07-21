part of 'recorder_bloc.dart';

abstract class RecorderEvent extends Equatable {
  const RecorderEvent();

  @override
  List<Object> get props => [];
}

class LoadRecorder extends RecorderEvent {}

class PressRecordButton extends RecorderEvent {}
