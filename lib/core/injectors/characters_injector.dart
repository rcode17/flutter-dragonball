import '../../features/characters/data/datasources/characters_remote_datasource.dart';
import '../../features/characters/data/repositories/character_repository_impl.dart';
import '../../features/characters/domain/repositories/character_repository.dart';
import '../../features/characters/domain/usecases/get_characters.dart';
import '../../features/characters/presentation/bloc/characters_bloc.dart';

import 'injector_all.dart';

Future<void> initCharactersInjector() async {
  // Data sources
  if (!gt.isRegistered<CharactersRemoteDatasource>()) {
    gt.registerLazySingleton<CharactersRemoteDatasource>(
      () => CharactersRemoteDatasourceImpl(gt()),
    );
  }

  // Repository
  if (!gt.isRegistered<CharacterRepository>()) {
    gt.registerLazySingleton<CharacterRepository>(
      () => CharacterRepositoryImpl(gt()),
    );
  }

  // Use cases
  if (!gt.isRegistered<GetCharacters>()) {
    gt.registerLazySingleton(() => GetCharacters(gt()));
  }

  // Bloc
  if (!gt.isRegistered<CharactersBloc>()) {
    gt.registerFactory(() => CharactersBloc(gt()));
  }
}
