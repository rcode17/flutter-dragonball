import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../planets/presentation/bloc/planet_bloc.dart';
import '../../planets/presentation/bloc/planet_state.dart';

class DocumentationPage extends StatelessWidget {
  const DocumentationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlanetBloc, PlanetState>(
      builder: (context, state) {
        if (state is PlanetFavoriteState &&
            state.favoritePlanet != null) {
          
          final planet = state.favoritePlanet!;

          final controller = WebViewController()
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..loadRequest(
              Uri.parse(
                'https://web.dragonball-api.com/documentation',
                // o: planet.documentationUrl
              ),
            );

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  'Planeta favorito: ${planet.name}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: WebViewWidget(controller: controller),
              ),
            ],
          );
        }

        // Si no hay planeta favorito
        return const Center(
          child: Text('Selecciona un planeta favorito'),
        );
      },
    );
  }
}
