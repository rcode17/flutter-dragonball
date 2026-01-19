import '../../domain/entities/paginated_planets.dart';
import 'planet_model.dart';
import 'pagination_meta_model.dart';

class PaginatedPlanetsModel extends PaginatedPlanets {
  const PaginatedPlanetsModel({
    required super.items,
    required super.meta,
  });

  factory PaginatedPlanetsModel.fromJson(Map<String, dynamic> json) {
    return PaginatedPlanetsModel(
      items: (json['items'] as List)
          .map((e) => PlanetModel.fromJson(e))
          .toList(),
      meta: PaginationMetaModel.fromJson(json['meta']),
    );
  }
}
