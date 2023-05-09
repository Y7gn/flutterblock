import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'buisness_logic/cubit/characters_cubit.dart';
import 'constants/strings.dart';
import 'data/models/characters.dart';
import 'data/repository/characters_repository.dart';
import 'presentation/screens/characters_details.dart';
import 'presentation/screens/characters_screen.dart';
import 'data/web_services/characters_web_services.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;

  AppRouter() {
    charactersRepository =
        CharactersRepository(charactersWebServices: CharactersWebServices());
    charactersCubit = CharactersCubit(charactersRepository);
  }
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => charactersCubit,
            child: CharactersScreen(),
          ),
        );
      // blocProvider.value(value:charactersCubit) i can pass cubit from widget to widget characterDetailsScreen
      case characterDetailsScreen:
        final character = settings.arguments
            as Character; // i will pass it argument to navigate to detail screen
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) => charactersCubit,
                child: CharacterDetailsScreen(character: character)));
    }
  }
}
