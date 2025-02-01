import 'package:flutter/material.dart';
import 'package:pokemon_gravity/core/theme/theme.dart';

class Loader extends StatelessWidget{
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
   return const Center(
    child: CircularProgressIndicator(
      // backgroundColor: ThemeColor.cardColor,
    ),
   );
  }
  
}