import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verse_ds/theme/verse_theme.dart';
import 'core/injectors/injector_all.dart';
import 'features/characters/presentation/bloc/characters_bloc.dart';
import 'features/characters/presentation/pages/characters_page.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/planets/presentation/pages/planets_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initInjectors();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dragon Ball',
      theme: VerseTheme.lightTheme,

      // ✅ Home global
      home: const HomePage(),

      // ✅ Rutas
      routes: {
        '/characters': (_) => BlocProvider<CharactersBloc>(
              create: (_) => gt<CharactersBloc>()
                ..add(const GetCharactersEvent(page: 1, limit: 5)),
              child: const CharactersPage(),
            ),

      // ✅ Planets SIN Bloc
      '/planets': (_) => const PlanetsPage(),
      },
    );
  }
}
