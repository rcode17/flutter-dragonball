

import 'package:dragonball/features/planets/presentation/bloc/planet_bloc.dart';

import '../../features/planets/data/datasources/planet_remote_datasource.dart';
import '../../features/planets/data/repositories/planet_repository_impl.dart';
import '../../features/planets/domain/repositories/planet_repository.dart';
import '../../features/planets/domain/usecases/get_planets.dart';
import 'injector_all.dart';

Future<void> initPlanets() async {
  // 🔹 Data sources
  gt.registerLazySingleton<PlanetRemoteDataSource>(
    () => PlanetRemoteDataSourceImpl(gt()),
  );

  // 🔹 Repository
  gt.registerLazySingleton<PlanetRepository>(
    () => PlanetRepositoryImpl(gt()),
  );

  gt.registerFactory<PlanetBloc>(
    () => PlanetBloc(),
  );


  // 🔹 Use cases
  gt.registerLazySingleton(() => GetPlanets(gt()));
}
