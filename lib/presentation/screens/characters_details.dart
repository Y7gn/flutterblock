import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterblock/constants/my_colors.dart';

import '../../buisness_logic/cubit/characters_cubit.dart';
import '../../data/models/characters.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Character character;
  const CharacterDetailsScreen({super.key, required this.character});

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600, // height of picture
      pinned: true,
      stretch: true, // not difference bc no list
      backgroundColor: myColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          character.name,
          style: const TextStyle(color: myColors.myWhite),
          textAlign: TextAlign.start,
        ),
        background: Hero(
          tag: character.charId,
          child: Image.network(
            character.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
        maxLines: 1,
        overflow: TextOverflow.ellipsis, // last ...
        text: TextSpan(children: [
          TextSpan(
              text: title,
              style: TextStyle(
                  color: myColors.myWhite,
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
          TextSpan(
              text: value,
              style: TextStyle(
                  color: myColors.myWhite,
                  fontWeight: FontWeight.bold,
                  fontSize: 16))
        ]));
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      height: 30,
      endIndent: endIndent,
      color: myColors.myYellow,
      thickness: 2,
    );
  }

  Widget checkIfQuotesAreLoaded(CharactersState state) {
    if (state is QuotesLoaded) {
      return displayRandomQuotesOrEmptySpace(state);
    } else {
      return ShowProgressIndicator();
    }
  }

  Widget displayRandomQuotesOrEmptySpace(state) {
    var quotes = (state).quotes;
    print("quote");
    print(quotes[0].quote);
    if (quotes.length != 0) {
      return Center(
        child: DefaultTextStyle(
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: myColors.myWhite, shadows: [
              Shadow(
                  blurRadius: 7, color: myColors.myYellow, offset: Offset(0, 0))
            ]),
            child: AnimatedTextKit(
                animatedTexts: [FlickerAnimatedText(quotes[0].quote)])),
      );
    } else {
      return Container(
        child: Text(
          "no data",
          style: TextStyle(color: myColors.myWhite),
        ),
      );
    }
  }

  Widget ShowProgressIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: myColors.myYellow,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharactersCubit>(context).getQuotes();
    return Scaffold(
      backgroundColor: myColors.myGrey,
      body: CustomScrollView(
        //you control slivers
        slivers: [
          //sliver appbar and sliverlist
          buildSliverAppBar(), // title and background (image with hero) and small title
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  characterInfo('Species: ', character.species),
                  buildDivider(300),
                  characterInfo(
                      'Appeared In: ',
                      character.episode.map((element) {
                        List<String> newElement = element.split("/");
                        return newElement.last;
                      }).toString()),
                  buildDivider(250),
                  characterInfo('Gender: ', character.gender),
                  buildDivider(40),
                  characterInfo('Status: ', character.status),
                  buildDivider(60),
                  characterInfo('Origin: ', character.origin["name"]),
                  buildDivider(200),
                  BlocBuilder<CharactersCubit, CharactersState>(
                    builder: (context, state) {
                      return checkIfQuotesAreLoaded(state);
                    },
                  ),
                  SizedBox(
                    height: 500,
                  ),
                ],
              ),
            )
          ]))
        ],
      ),
    );
  }
}
