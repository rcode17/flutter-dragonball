import 'package:dragonball/features/planets/domain/entities/planet.dart';
import 'package:equatable/equatable.dart';

sealed class PlanetState extends Equatable {
  const PlanetState();

  @override
  List<Object?> get props => [];
}

final class PlanetFavoriteState extends PlanetState {
  final Planet? favoritePlanet;

  const PlanetFavoriteState({this.favoritePlanet});

  @override
  List<Object?> get props => [favoritePlanet];
}