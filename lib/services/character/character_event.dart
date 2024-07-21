part of 'character_bloc.dart';

abstract class CharacterEvent extends Equatable {
  const CharacterEvent();

  @override
  List<Object> get props => [];
}

class InitializeCharacter extends CharacterEvent {}

class LoadCharacter extends CharacterEvent {
  final Character character;

  const LoadCharacter({required this.character});

  @override
  List<Object> get props => [character];
}
