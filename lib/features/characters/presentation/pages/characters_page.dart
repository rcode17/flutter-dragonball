import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/characters_bloc.dart';
import '../bloc/characters_state.dart';
import '../widgets/character_list_item.dart';


class CharactersPage extends StatelessWidget {
  const CharactersPage({super.key});

  void _load(BuildContext context) {
    context.read<CharactersBloc>().add(const GetCharactersEvent(page: 1, limit: 5));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dragon Ball Characters'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _load(context),
          )
        ],
      ),
      body: BlocBuilder<CharactersBloc, CharactersState>(
        builder: (context, state) {
          if (state is CharactersInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CharactersLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CharactersError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.error_outline, size: 48),
                    const SizedBox(height: 12),
                    Text(
                      'Ocurrió un error:\n${state.message}',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => _load(context),
                      child: const Text('Reintentar'),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is CharactersLoaded) {
            final characters = state.characters;

            if (characters.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('No hay personajes para mostrar'),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => _load(context),
                      child: const Text('Recargar'),
                    ),
                  ],
                ),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: characters.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final c = characters[index];
                return CharacterListItem(character: c);
              },
            );
          }

          // Fallback por seguridad
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
