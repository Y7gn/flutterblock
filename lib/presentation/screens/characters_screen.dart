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

  @override
  void initState() {
    super.initState();
    allcharacters = BlocProvider.of<CharactersCubit>(context)
        .getAllCharacters(); //empty list
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
        builder: (context, state) {
      if (state is CharactersLoaded) {
        allcharacters = (state).characters; //filled from server
        return buildLoadedListWidgets();
      } else {
        return Center(child: CircularProgressIndicator());
      }
    });
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
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, //in one line
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ),
        itemBuilder: (context, index) {
          //TODO
          return CharacterItem();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myColors.myYellow,
        title: Text(
          "Characters",
          style: TextStyle(color: myColors.myGrey),
        ),
      ),
      body: buildBlocWidget(), //builder consumer listener
    );
  }
}
