import 'package:flutter/material.dart';
import 'package:pokemon_gravity/core/theme/theme.dart';

class customText extends StatelessWidget
{
  final String strText;
  final double size;
  final FontWeight weight;

  const customText({super.key, required this.strText,this.size = 14,this.weight=FontWeight.w400});
  @override
  Widget build(BuildContext context) {
   
    return Text(strText,
      style: TextStyle(
        fontSize: size,
        fontWeight: weight,
        color: ThemeColor.textColor
      ),
    );
  }
  
}