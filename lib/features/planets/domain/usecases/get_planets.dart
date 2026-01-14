import '../entities/paginated_planets.dart';
import '../repositories/planet_repository.dart';

class GetPlanets {
  
  final PlanetRepository repository;

  GetPlanets(this.repository);

  Future<PaginatedPlanets> call({
    int page = 1,
    int limit = 10,
  }) {
    return repository.getPlanets(
      page: page,
      limit: limit,
    );
  }
}
