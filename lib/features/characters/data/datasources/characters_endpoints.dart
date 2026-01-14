import 'package:dragonball/core/network/env.dart';

class CharactersEndpoints {
  static String characters({required int page, required int limit}) =>
      '${Env.apiBaseUrl}/characters?page=$page&limit=$limit';
}