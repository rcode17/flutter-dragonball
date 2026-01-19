import '../../domain/entities/character.dart';
import '../../domain/repositories/character_repository.dart';
import '../datasources/characters_remote_datasource.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharactersRemoteDatasource remoteDatasource;

  CharacterRepositoryImpl(this.remoteDatasource);

  @override
  Future<List<Character>> getCharacters({
    int page = 1,
    int limit = 5,
  }) async {
    final models = await remoteDatasource.getCharacters(page: page, limit: limit);
    // Como CharacterModel extiende Character, podemos devolverlos directo como entidad.
    return models;
  }
}
