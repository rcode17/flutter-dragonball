import 'package:dragonball/core/injectors/planets_injector.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'characters_injector.dart';

final gt = GetIt.instance;

Future<void> initInjectors() async {

  gt.registerLazySingleton<http.Client>(() => http.Client());

  await initPlanets(); 
  await initCharactersInjector();
}
