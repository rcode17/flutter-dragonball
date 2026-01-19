import '../../domain/entities/character.dart';

class CharacterModel extends Character {
  const CharacterModel({
    required super.id,
    required super.name,
    required super.ki,
    required super.image,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: (json['name'] as String?) ?? '',
      ki: (json['ki'] as String?) ?? '',
      image: (json['image'] as String?) ?? '',
    );
  }
}