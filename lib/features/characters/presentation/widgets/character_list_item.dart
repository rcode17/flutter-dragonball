import 'package:flutter/material.dart';
import '../../domain/entities/character.dart';

class CharacterListItem extends StatelessWidget {
  final Character character;

  const CharacterListItem({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            character.image,
            width: 56,
            height: 56,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.image_not_supported),
          ),
        ),
        title: Text(
          character.name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text('Ki: ${character.ki}'),
      ),
    );
  }
}
