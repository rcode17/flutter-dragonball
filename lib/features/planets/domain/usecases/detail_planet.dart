import 'package:dragonball/features/planets/data/models/detail_planet_model.dart';
import 'package:dragonball/features/planets/domain/repositories/planet_repository.dart';

class GetDetailPlanetuseCase {
  final PlanetRepository repository;

  GetDetailPlanetuseCase(this.repository);

  Future<DetailPlanetModel> call(int id) {
    return repository.getDetailPlanet(id);
  }
}