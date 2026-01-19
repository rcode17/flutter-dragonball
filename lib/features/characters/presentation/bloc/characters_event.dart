part of 'characters_bloc.dart';

abstract class CharactersEvent extends Equatable {
  const CharactersEvent();

  @override
  List<Object?> get props => [];
}

class GetCharactersEvent extends CharactersEvent {
  final int page;
  final int limit;

  const GetCharactersEvent({this.page = 1, this.limit = 5});

  @override
  List<Object?> get props => [page, limit];
}
