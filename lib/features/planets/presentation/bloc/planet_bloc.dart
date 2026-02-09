import 'package:dragonball/features/planets/presentation/bloc/favorite_planet_event.dart';
import 'package:dragonball/features/planets/presentation/bloc/planet_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlanetBloc extends Bloc<PlanetEvent, PlanetState> {
  
  PlanetBloc() : super(const PlanetFavoriteState()) {
    on<SetFavoritePlanetEvent>(_onSetFavoritePlanet);
  }

  void _onSetFavoritePlanet(
    SetFavoritePlanetEvent event,
    Emitter<PlanetState> emit,
  ) {
    emit(
      PlanetFavoriteState(
        favoritePlanet: event.planet,
      ),
    );
  }
}
