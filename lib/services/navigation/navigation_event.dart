part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class LoadIndexNavigation extends NavigationEvent {
  const LoadIndexNavigation();

  @override
  List<Object> get props => [];
}

class ChangeIndexNavigation extends NavigationEvent {
  final NavigationEnum index;

  const ChangeIndexNavigation({required this.index});

  @override
  List<Object> get props => [index];
}

class SendAudio extends NavigationEvent {
  final String filePath;

  const SendAudio({required this.filePath});

  @override
  List<Object> get props => [filePath];
}
