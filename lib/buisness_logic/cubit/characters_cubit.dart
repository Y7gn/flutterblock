import 'package:bloc/bloc.dart';
import 'package:flutterblock/data/repository/characters_repository.dart';
import 'package:meta/meta.dart';
//in this file i start working with cubit states

import '../../data/models/characters.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;
  CharactersCubit(this.charactersRepository) : super(CharactersInitial());
  late List<Character> characters;

  List<Character> getAllCharacters() {
    // i will get data from repository
    charactersRepository.getAllCharacters().then((characters) {
      emit(CharactersLoaded(characters: characters)); // start
      this.characters =
          characters; // it can be mycharacters if in 13  mycharacters
    });

    return getAllCharacters();
  }
}
