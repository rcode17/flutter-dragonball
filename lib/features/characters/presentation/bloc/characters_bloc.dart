import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_characters.dart';
import 'characters_state.dart';
import '../../../../core/error/exceptions.dart';

part 'characters_event.dart';



class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final GetCharacters getCharacters;

  CharactersBloc(this.getCharacters) : super(const CharactersInitial()) {
    on<GetCharactersEvent>(_onGetCharacters);
  }

  Future<void> _onGetCharacters(
    GetCharactersEvent event,
    Emitter<CharactersState> emit,
  ) async {
    emit(const CharactersLoading());
    try {
      final characters = await getCharacters(page: event.page, limit: event.limit);
      emit(CharactersLoaded(characters));
    } on ServerException catch (_) {
      emit(const CharactersError('No se pudieron cargar los personajes. Intenta de nuevo.'));
    } catch (_) {
      emit(const CharactersError('Ocurrió un error inesperado.'));
    }
  }
}
