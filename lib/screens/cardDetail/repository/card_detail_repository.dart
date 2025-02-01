import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:pokemon_gravity/core/appfailure/app_failure.dart';
import 'package:pokemon_gravity/core/server/webservice.dart';
import 'package:pokemon_gravity/model/pokemon_card.dart';

class CardDetailRepository{
  Future<Either<AppFailure,PokemonCard>> getCardDetail(String? id) async{
    try{

      final res = await Webservice().getApicall("?q=id:${id!}");
      var resBody = jsonDecode(res.body);
      if(res.statusCode != 200){
        return Left(AppFailure(message: resBody["error"]["message"]));
      }

        List<PokemonCard>  cardList = (resBody["data"] as List) 
        .map((item) => PokemonCard.fromJson(item as Map<String, dynamic>)) 
        .toList();
        return Right(cardList[0]);
      
   

    }catch(e){
      return Left(AppFailure(message: e.toString()));
    }
  }
}