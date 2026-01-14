import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../core/network/env.dart';
import '../models/character_model.dart';
import '../../../../core/error/exceptions.dart';


abstract class CharactersRemoteDatasource {
  Future<List<CharacterModel>> getCharacters({
    int page = 1,
    int limit = 5,
  });
}

class CharactersRemoteDatasourceImpl implements CharactersRemoteDatasource {
  final http.Client client;

  CharactersRemoteDatasourceImpl(this.client);

  @override
  Future<List<CharacterModel>> getCharacters({
    int page = 1,
    int limit = 5,
  }) async {
    final uri = Uri.parse('${Env.apiBaseUrl}/characters?page=$page&limit=$limit');

    final response = await client.get(uri);

    if (response.statusCode != 200) {
      throw ServerException('Error HTTP: ${response.statusCode}');
    }

    final Map<String, dynamic> decoded = jsonDecode(response.body);
    final List<dynamic> items = (decoded['items'] as List<dynamic>? ) ?? [];

    return items
        .map((e) => CharacterModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}