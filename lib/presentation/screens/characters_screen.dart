import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterblock/constants/my_colors.dart';

import '../../buisness_logic/cubit/characters_cubit.dart';
import '../../data/models/characters.dart';
import '../widgets/character_item.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<Character> allcharacters;
  late List<Character> searchedForCharacter;
  bool _isSearching = false;
  final _searchTextController = TextEditingController();

  Widget _buildSearchField() {
    return TextField(
      controller: _searchTextController,
      cursorColor: myColors.myGrey,
      decoration: const InputDecoration(
        hintText: "find a character",
        border: InputBorder.none,
        hintStyle: TextStyle(color: myColors.myGrey, fontSize: 18),
      ),
      style: TextStyle(color: myColors.myGrey, fontSize: 18),
      onChanged: (searchedCharacter) {
        addSearchedWordToSearchedList(
            searchedCharacter); // function to take text or character and work on filtering it
      },
    );
  }

  void addSearchedWordToSearchedList(String searchedCharacter) {
    searchedForCharacter = allcharacters
        .where(
            (element) => element.name.toLowerCase().contains(searchedCharacter))
        .toList();

    setState(() {
      //UI
    });
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
            onPressed: () {
              // searchedForCharacter=[];
              // _isSearching=false;
              _clearSearch();
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.clear,
              color: myColors.myGrey,
            ))
      ];
    } else {
      return [
        IconButton(
            onPressed: _startSearch,
            icon: Icon(
              Icons.search,
              color: myColors.myGrey,
            ))
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!.addLocalHistoryEntry(LocalHistoryEntry(
        onRemove: _stopSearch)); //when navigate from screen to screen

    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearch() {
    _clearSearch();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchTextController.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(
            context) //dont be lazy  i want to use ur data
        .getAllCharacters(); //empty list
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
        builder: (context, state) {
      if (state is CharactersLoaded) {
        allcharacters = (state).characters; //filled from server   19
        return buildLoadedListWidgets();
      } else {
        // return showLoadingIndicator();
        return Center(child: CircularProgressIndicator());
      }
    });
  }

  Widget showLoadingIndicator() {
    return CircularProgressIndicator(
      color: myColors.myYellow,
    );
  }

  Widget buildLoadedListWidgets() {
    return SingleChildScrollView(
      child: Container(
        color: myColors.myGrey,
        child: Column(
          children: [
            buildCharactersList(),
          ],
        ),
      ),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, //in one line
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ),
        shrinkWrap: true,
        itemCount: _searchTextController.text.isEmpty
            ? allcharacters.length
            : searchedForCharacter.length,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          //TODO
          return CharacterItem(
            character: _searchTextController.text.isEmpty
                ? allcharacters[
                    index] // i get object (characterItem)so when i pass it i pass the whole object
                : searchedForCharacter[index],
          );
        });
  }

  Widget _buildAppBarTitle() {
    return Text(
      "Characters",
      style: TextStyle(color: myColors.myGrey),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myColors.myYellow,
        leading: _isSearching
            ? BackButton(
                color: myColors.myGrey,
              )
            : Container(),
        title: _isSearching ? _buildSearchField() : _buildAppBarTitle(),
        actions: _buildAppBarActions(),
        // leading: _isSearching?const ,
      ),
      body: buildBlocWidget(), //builder consumer listener
    );
  }
}
