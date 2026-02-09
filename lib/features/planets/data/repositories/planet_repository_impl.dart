import 'package:dragonball/features/planets/data/models/detail_planet_model.dart';

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

  @override
  Future<DetailPlanetModel> getDetailPlanet(int id) {
    return remoteDataSource.getDetailPlanet(id);
  }
}
