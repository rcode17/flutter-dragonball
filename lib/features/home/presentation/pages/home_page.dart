import 'package:dragonball/features/characters/presentation/bloc/characters_bloc.dart';
import 'package:dragonball/features/characters/presentation/pages/characters_page.dart';
import 'package:dragonball/features/documentations/presentation/documentation.dart';
import 'package:dragonball/features/planets/presentation/bloc/planet_bloc.dart';
import 'package:dragonball/features/planets/presentation/pages/planets_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/injectors/injector_all.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;
  final List<String> titles = ['Characters', 'Planets', 'Documentation'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentPageIndex,
        onDestinationSelected: (index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        destinations: const <Widget>[
          NavigationDestination(icon: Icon(Icons.explore), label: 'Characters'),
          NavigationDestination(icon: Icon(Icons.commute), label: 'Planets'),
          NavigationDestination(
            icon: Icon(Icons.document_scanner),
            label: 'Documentation',
          ),
        ],
      ),
      appBar: AppBar(title: Text(titles[currentPageIndex])),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<PlanetBloc>(create: (_) => gt<PlanetBloc>()),
          BlocProvider<CharactersBloc>(
            create: (_) =>
                gt<CharactersBloc>()
                  ..add(const GetCharactersEvent(page: 1, limit: 5)),
          ),
        ],
        child: IndexedStack(
          index: currentPageIndex,
          children: const [
            CharactersPage(),
            PlanetsPage(),
            DocumentationPage(),
          ],
        ),
      ),
    );
  }
}
