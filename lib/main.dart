import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_gravity/core/routes/route_constants.dart';
import 'package:pokemon_gravity/core/routes/route_handling.dart';
import 'package:pokemon_gravity/core/theme/theme.dart';
import 'package:pokemon_gravity/screens/cardList/repository/card_list_repository.dart';
import 'package:pokemon_gravity/screens/cardList/view/card_list_screen.dart';

import 'screens/cardList/bloc/card_list_bloc_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CardListBlocBloc(cardListRepository: CardListRepository())..add(CardListBlocLoadEvent(page: 1)),
      child: MaterialApp(
        title: 'Pokemon Gravity',
        initialRoute: RouteConstants.rSplashScreen, // initial route is splash screen then navigates to list screen
        onGenerateRoute: RoutesHandling.generateRoute, 
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: ThemeColor.appBarColor),
          useMaterial3: true,
        ),
      ),
    );
  }
}
