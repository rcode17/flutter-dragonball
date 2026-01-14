import '../entities/paginated_planets.dart';

abstract class PlanetRepository {
  Future<PaginatedPlanets> getPlanets({
    int page = 1,
    int limit = 10,
  });
}
