import '../../domain/entities/paginated_planets.dart';
import '../../domain/repositories/planet_repository.dart';
import '../datasources/planet_remote_datasource.dart';

class PlanetRepositoryImpl implements PlanetRepository {
  final PlanetRemoteDataSource remoteDataSource;

  PlanetRepositoryImpl(this.remoteDataSource);

  @override
  Future<PaginatedPlanets> getPlanets({
    int page = 1,
    int limit = 10,
  }) {
    return remoteDataSource.getPlanets(
      page: page,
      limit: limit,
    );
  }
}
