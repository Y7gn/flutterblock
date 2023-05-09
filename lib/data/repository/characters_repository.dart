// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutterblock/data/models/quotes.dart';

import '../models/characters.dart';
import '../web_services/characters_web_services.dart';

class CharactersRepository {
  final CharactersWebServices charactersWebServices;
  CharactersRepository({
    required this.charactersWebServices,
  });

  Future<List<Character>> getAllCharacters() async {
    final characters = await charactersWebServices.getAllCharacters();
    return characters.map((e) => Character.fromJson(e)).toList();
  }

  Future<List<Quote>> getCharactersQuotes() async {
    final quotes = await charactersWebServices.getCharactersQuotes();
    return quotes.map((e) => Quote.fromJson(e)).toList();
  }
}
