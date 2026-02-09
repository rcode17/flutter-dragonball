import 'dart:convert';
import 'package:dragonball/features/planets/data/models/detail_planet_model.dart';
import 'package:http/http.dart' as http;

import '../models/paginated_planets_model.dart';

abstract class PlanetRemoteDataSource {
  Future<PaginatedPlanetsModel> getPlanets({
    required int page,
    required int limit,
  });

  Future<DetailPlanetModel> getDetailPlanet(int id);
}

class PlanetRemoteDataSourceImpl implements PlanetRemoteDataSource {
  final http.Client client;

  PlanetRemoteDataSourceImpl(this.client);

  @override
  Future<PaginatedPlanetsModel> getPlanets({
    required int page,
    required int limit,
  }) async {
    final response = await client.get(
      Uri.parse(
        'https://dragonball-api.com/api/planets?page=$page&limit=$limit',
      ),
    );

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      return PaginatedPlanetsModel.fromJson(decoded);
    } else {
      throw Exception('Server error');
    }
  }
  
  @override
  Future<DetailPlanetModel> getDetailPlanet(int id) async {
    final response = await client.get(
      Uri.parse(
        'https://dragonball-api.com/api/planets/$id',
      ),
    );

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      return DetailPlanetModel.fromJson(decoded);
    } else {
      throw Exception('Server error');
    }
  }
}
