import 'package:flutter/material.dart';

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

  bool _isLoading = false;
  String? _errorMessage;
  List<Planet> _planets = [];
  PaginationMeta? _meta;

  @override
  void initState() {
    super.initState();
    _getPlanets = gt<GetPlanets>();
    _loadPlanets();
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
    return Scaffold(
      appBar: AppBar(title: const Text('Planetas')),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(child: Text(_errorMessage!));
    }

    return ListView.builder(
    padding: const EdgeInsets.all(spacing2),
    itemCount: _planets.length,
    itemBuilder: (context, index) {
    final planet = _planets[index];

    return Padding(
      padding: const EdgeInsets.only(bottom: spacing2),
      child: DashboardCardContainer(
        child: ListTile(
          leading: Image.network(
            planet.image,
            width: 50,
            errorBuilder: (context, error, stackTrace) => const Icon(Icons.public),
          ),
          title: Text(planet.name),
          subtitle: Text(
            planet.description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  },
);
  }
}
