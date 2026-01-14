import 'package:equatable/equatable.dart';
import '../../domain/entities/character.dart';

abstract class CharactersState extends Equatable {
  const CharactersState();

  @override
  List<Object?> get props => [];
}

class CharactersInitial extends CharactersState {
  const CharactersInitial();
}

class CharactersLoading extends CharactersState {
  const CharactersLoading();
}

class CharactersLoaded extends CharactersState {
  final List<Character> characters;

  const CharactersLoaded(this.characters);

  @override
  List<Object?> get props => [characters];
}

class CharactersError extends CharactersState {
  final String message;

  const CharactersError(this.message);

  @override
  List<Object?> get props => [message];
}
