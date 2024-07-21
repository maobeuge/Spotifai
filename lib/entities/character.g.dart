// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Character _$CharacterFromJson(Map<String, dynamic> json) => Character(
      id: json['id'] as String,
      voiceId: json['voice_id'] as String,
      imageUrl: json['thumbnail'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$CharacterToJson(Character instance) => <String, dynamic>{
      'id': instance.id,
      'voice_id': instance.voiceId,
      'name': instance.name,
      'thumbnail': instance.imageUrl,
    };
