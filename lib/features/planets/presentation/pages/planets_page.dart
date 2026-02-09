import 'package:dragonball/features/planets/presentation/bloc/favorite_planet_event.dart';
import 'package:dragonball/features/planets/presentation/bloc/planet_bloc.dart';
import 'package:dragonball/features/planets/presentation/bloc/planet_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/injectors/injector_all.dart';
import '../../domain/entities/planet.dart';
import '../../domain/entities/pagination_meta.dart';
import '../../domain/usecases/get_planets.dart';
import 'package:verse_ds/design/organisms/cards/dashboard_card_container.dart';
import 'package:verse_ds/design/tokens/spacing.dart';

class PlanetsPage extends StatefulWidget {
  const PlanetsPage({super.key});

  @override
  State<PlanetsPage> createState() => _PlanetsPageState();
}

class _PlanetsPageState extends State<PlanetsPage> {
  late final GetPlanets _getPlanets;
  late final WebViewController _controller;

  bool _isLoading = false;
  String? _errorMessage;
  List<Planet> _planets = [];
  PaginationMeta? _meta;

  @override
  void initState() {
    super.initState();
    _getPlanets = gt<GetPlanets>();
    _loadPlanets();
    _controller = WebViewController()
      ..setJavaScriptMode(
        JavaScriptMode.unrestricted,
      ) // Permite ejecución de JS
      ..setBackgroundColor(const Color(0x00000000))
      ..loadRequest(Uri.parse('https://pub.dev/'));
  }

  Future<void> _loadPlanets({int page = 1}) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final result = await _getPlanets(page: page);
      setState(() {
        _planets = result.items;
        _meta = result.meta;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error cargando planetas';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(child: Text(_errorMessage!));
    }

    if (_planets.isEmpty) {
      return const Center(child: Text('No hay planetas'));
    }

    final width = MediaQuery.of(context).size.width;

    int crossAxisCount;
    double childAspectRatio;

    if (width < 600) {
      crossAxisCount = 1;
      childAspectRatio = 3.5; // Row necesita más ancho
    } else if (width < 1024) {
      crossAxisCount = 2;
      childAspectRatio = 3.8;
    } else {
      crossAxisCount = 3;
      childAspectRatio = 4.0;
    }

    return GridView.builder(
      padding: const EdgeInsets.all(spacing2),
      itemCount: _planets.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: spacing2,
        crossAxisSpacing: spacing2,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) {
        final planet = _planets[index];

        return DashboardCardContainer(child: contentPlanetInfo(planet));
      },
    );
  }

  Widget contentPlanetInfo(Planet planet) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          height: 120,
          child: Image.network(
            planet.image,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => const Icon(Icons.public, size: 20),
          ),
        ),

        const SizedBox(width: 8),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🪐 TÍTULO
              Text(
                planet.name,
                style: Theme.of(context).textTheme.titleMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 4),

              /// 📄 DESCRIPCIÓN
              Text(
                planet.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14, height: 1.3),
              ),
              WebViewWidget(controller: _controller),
            ],
          ),
        ),

        const SizedBox(width: 8),

        /// 🟦 ACCIÓN DE CONTEXTO
        ElevatedButton(
          onPressed: () => _showWebView(
            context,
            'https://pub.dev/',
          ), // Aquí iría planet.wikiUrl o similar
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(40, 32),
            padding: const EdgeInsets.symmetric(horizontal: 12),
          ),
          child: const Text('Ver', style: TextStyle(fontSize: 12)),
        ),
        BlocBuilder<PlanetBloc, PlanetState>(
          builder: (context, state) {
            final isFavorite =
                state is PlanetFavoriteState &&
                state.favoritePlanet?.id == planet.id;

            return IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey,
              ),
              onPressed: () {
                context.read<PlanetBloc>().add(SetFavoritePlanetEvent(planet));
              },
            );
          },
        ),
      ],
    );
  }

  void _showWebView(BuildContext context, String url) {
    // Inicializamos el controlador justo antes de mostrarlo
    final WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..loadRequest(Uri.parse(url));

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Permite que use más espacio
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.85, // 85% de la pantalla
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            // Barra de control (Criterio de HU.7: Iconos intuitivos)
            ListTile(
              title: const Text("Documentación del Planeta"),
              trailing: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Expanded(child: WebViewWidget(controller: controller)),
          ],
        ),
      ),
    );
  }
}
