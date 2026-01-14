import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/paginated_planets_model.dart';

abstract class PlanetRemoteDataSource {
  Future<PaginatedPlanetsModel> getPlanets({
    required int page,
    required int limit,
  });
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
}
