
import 'package:equatable/equatable.dart';

class Character extends Equatable {
  final int id;
  final String name;
  final String ki;
  final String image;

  const Character({
    required this.id,
    required this.name,
    required this.ki,
    required this.image,
  });

  @override
  List<Object?> get props => [id, name, ki, image];
}