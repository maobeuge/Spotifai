part of 'navigation_bloc.dart';

abstract class NavigationState extends Equatable {
  const NavigationState();

  @override
  List<Object> get props => [];
}

class NavigationInitial extends NavigationState {}

class NavigationLoaded extends NavigationState {
  final NavigationEnum index;

  const NavigationLoaded({required this.index});

  @override
  List<Object> get props => [index];
}
