// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'characters_cubit.dart';

//in this file i do all the states
@immutable
abstract class CharactersState {}

class CharactersInitial extends CharactersState {}

// class CharactersErrorCase extends CharactersState{ if i want to do error case , or loading state

// }
class CharactersLoaded extends CharactersState {
  final List<Character> characters; //list
  CharactersLoaded({
    required this.characters,
  });
}
