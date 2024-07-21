import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spotifai/constants/ui_helper.dart';
import 'package:spotifai/domain/ai_repository/ai_repository.dart';
import 'package:spotifai/entities/character.dart';

part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  AiRepository aiRepository = AiRepository();
  List<Character> characterList = [];

  CharacterBloc() : super(CharacterInitial()) {
    on<InitializeCharacter>((event, emit) async {
      ResponseModel response = await aiRepository.getVoices();
      print(response.content);
      characterList = response.content['characters'];

      emit(NoCharacterLoaded(characterList: characterList));
    });

    on<LoadCharacter>((event, emit) {
      final Character newCharacter = Character(
        id: event.character.id,
        voiceId: event.character.voiceId,
        imageUrl: event.character.imageUrl,
        name: event.character.name,
      );

      emit(CharacterLoaded(
          character: newCharacter, characterList: characterList));
    });
  }
}
