import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../../features/planets/data/datasources/planet_remote_datasource.dart';
import '../../features/planets/data/repositories/planet_repository_impl.dart';
import '../../features/planets/domain/repositories/planet_repository.dart';
import '../../features/planets/domain/usecases/get_planets.dart';

final sl = GetIt.instance;

void initPlanets() {
  // 🔹 External
  sl.registerLazySingleton(() => http.Client());

  // 🔹 Data sources
  sl.registerLazySingleton<PlanetRemoteDataSource>(
    () => PlanetRemoteDataSourceImpl(sl()),
  );

  // 🔹 Repository
  sl.registerLazySingleton<PlanetRepository>(
    () => PlanetRepositoryImpl(sl()),
  );

  // 🔹 Use cases
  sl.registerLazySingleton(() => GetPlanets(sl()));
}
