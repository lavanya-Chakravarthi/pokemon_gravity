import 'package:flutter/material.dart';
import 'dart:async';

import 'package:pokemon_gravity/core/routes/route_constants.dart';
import 'package:pokemon_gravity/core/theme/theme.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushNamedAndRemoveUntil(context,RouteConstants.rCardListScreen,(route)=>false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: ThemeColor.cardColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/pokemon.png")            
          ],
        ),
      ),
    );
  }
}
