import 'package:dragonball/features/planets/data/models/detail_planet_model.dart';

import '../entities/paginated_planets.dart';

abstract class PlanetRepository {
  Future<PaginatedPlanets> getPlanets({
    int page = 1,
    int limit = 10,
  });

  Future<DetailPlanetModel> getDetailPlanet(int id);
}
