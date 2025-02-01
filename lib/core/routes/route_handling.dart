import 'package:flutter/material.dart';
import 'package:pokemon_gravity/core/routes/route_constants.dart';
import 'package:pokemon_gravity/screens/cardDetail/view/card_detail_view.dart';
import 'package:pokemon_gravity/screens/cardList/view/card_list_screen.dart';

import '../../screens/splash/splash_screen.dart';

class RoutesHandling{
 static Route generateRoute(RouteSettings routeSettings){
  switch (routeSettings.name) {
    case RouteConstants.rSplashScreen:
        return MaterialPageRoute(builder: (_) =>  SplashScreen());
    case RouteConstants.rCardListScreen:
      return MaterialPageRoute(builder: (_) =>  const CardListScreen());
    case RouteConstants.rCardDetailScreen:
      final args= routeSettings.arguments as String;
      return MaterialPageRoute(builder: (_) =>   CardDetailScreen(id: args));
    default:
      return MaterialPageRoute(builder: (_) =>  const CardListScreen());
  }
 }
}