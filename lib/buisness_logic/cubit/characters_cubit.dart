import 'package:bloc/bloc.dart';
import 'package:flutterblock/data/models/quotes.dart';
import 'package:flutterblock/data/repository/characters_repository.dart';
import 'package:meta/meta.dart';
//in this file i start working with cubit states

import '../../data/models/characters.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;
  List<Character> mycharacters = [];
  List<Quote> quotes = [];
  CharactersCubit(this.charactersRepository) : super(CharactersInitial());

  List<Character> getAllCharacters() {
    // i will get data from repository
    charactersRepository.getAllCharacters().then((characters) {
      emit(CharactersLoaded(characters: characters)); // start
      mycharacters =
          characters; // it can be mycharacters if in 13  mycharacters
    });

    return mycharacters;
  }

  List<Quote> getQuotes() {
    // i will get data from repository
    charactersRepository.getCharactersQuotes().then((quotes) {
      emit(QuotesLoaded(quotes: quotes)); // start
      quotes = quotes; // it can be mycharacters if in 13  mycharacters
    });

    return quotes;
  }
}
