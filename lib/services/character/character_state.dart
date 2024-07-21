part of 'character_bloc.dart';

abstract class CharacterState extends Equatable {
  const CharacterState();

  @override
  List<Object> get props => [];
}

class CharacterInitial extends CharacterState {}

class NoCharacterLoaded extends CharacterState {
  final List<Character> characterList;

  const NoCharacterLoaded({required this.characterList});

  @override
  List<Object> get props => [characterList];
}

class CharacterLoaded extends CharacterState {
  final Character character;
  final List<Character> characterList;

  const CharacterLoaded({required this.character, required this.characterList});

  @override
  List<Object> get props => [character, characterList];
}
