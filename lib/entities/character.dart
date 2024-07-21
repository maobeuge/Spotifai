import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'character.g.dart';

@JsonSerializable()
class Character extends Equatable {
  final String id;
  @JsonKey(name: 'voice_id')
  final String voiceId;
  final String name;
  @JsonKey(name: 'thumbnail')
  final String imageUrl;

  const Character({
    required this.id,
    required this.voiceId,
    required this.imageUrl,
    required this.name,
  });

  //Convert all Json data into Dart class
  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);

  //Convert dart class into Json format
  Map<String, dynamic> toJson() => _$CharacterToJson(this);

  @override
  List<Object?> get props => [id, voiceId, name, imageUrl];
}
