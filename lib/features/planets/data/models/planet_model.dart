import '../../domain/entities/planet.dart';

class PlanetModel extends Planet {
  const PlanetModel({
    required super.id,
    required super.name,
    required super.isDestroyed,
    required super.description,
    required super.image,
    super.deletedAt,
  });

  factory PlanetModel.fromJson(Map<String, dynamic> json) {
    return PlanetModel(
      id: json['id'],
      name: json['name'],
      isDestroyed: json['isDestroyed'],
      description: json['description'],
      image: json['image'],
      deletedAt: json['deletedAt'] != null
          ? DateTime.parse(json['deletedAt'])
          : null,
    );
  }
}