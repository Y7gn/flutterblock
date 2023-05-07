// ignore_for_file: public_member_api_docs, sort_constructors_first
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
}
