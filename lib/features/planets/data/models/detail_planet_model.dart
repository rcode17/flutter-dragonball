

class DetailPlanetModel {
  final int id;
  final String name;
  final bool isDestroyed;
  final String description;
  final String image;
  //final List<Character> characters;

  DetailPlanetModel({
    required this.id,
    required this.name,
    required this.isDestroyed,
    required this.description,
    required this.image,
    //required this.characters,
  });

  factory DetailPlanetModel.fromJson(Map<String, dynamic> json) {
    //var characterList = json['characters'] as List;
    //List<Character> characterObjects = characterList.map((character) => Character.fromJson(character)).toList();

    return DetailPlanetModel(
      id: json['id'],
      name: json['name'],
      isDestroyed: json['isDestroyed'],
      description: json['description'],
      image: json['image'],
      //characters: characterObjects,
    );
  }
}