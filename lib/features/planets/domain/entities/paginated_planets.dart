import 'planet.dart';
import 'pagination_meta.dart';

class PaginatedPlanets {
  final List<Planet> items;
  final PaginationMeta meta;

  const PaginatedPlanets({
    required this.items,
    required this.meta,
  });
}