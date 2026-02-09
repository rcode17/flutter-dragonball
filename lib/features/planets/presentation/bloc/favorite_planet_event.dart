import 'package:dragonball/features/planets/domain/entities/planet.dart';
import 'package:equatable/equatable.dart';

sealed class PlanetEvent extends Equatable {

  const PlanetEvent();

  @override
  List<Object?> get props => [];
}

final class SetFavoritePlanetEvent extends PlanetEvent {
  final Planet planet;

  const SetFavoritePlanetEvent(this.planet);

  @override
  List<Object?> get props => [planet];
}