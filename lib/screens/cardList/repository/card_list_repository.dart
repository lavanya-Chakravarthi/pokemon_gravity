import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:pokemon_gravity/core/server/webservice.dart';
import 'package:pokemon_gravity/model/pokemon_card.dart';

import '../../../core/appfailure/app_failure.dart';

class CardListRepository{
  Future<Either<AppFailure,List<PokemonCard>>> getCardList(int? page) async{
    final response = await Webservice().getApicall("?page=${page!}&pageSize=10");
    var resBody = jsonDecode(response.body);
    if(response.statusCode != 200){
      return Left(AppFailure(message: resBody["error"]["message"]));
    }
    if (resBody["data"] is List) {
      
        List<PokemonCard>  cardList = (resBody["data"] as List) 
        .map((item) => PokemonCard.fromJson(item as Map<String, dynamic>)) 
        .toList();
        return Right(cardList);
      } else {
        return Left(AppFailure(message: "Invalid response format"));
      }
  }


  Future<Either<AppFailure,List<PokemonCard>>> getSearchCardList(String? query) async{
    final response = await Webservice().getApicall("?q=name:${query!}");
    var resBody = jsonDecode(response.body);
    if(response.statusCode != 200){
      return Left(AppFailure(message: resBody["error"]["message"]));
    }
    if (resBody["data"] is List) {
      
        List<PokemonCard>  cardList = (resBody["data"] as List) 
        .map((item) => PokemonCard.fromJson(item as Map<String, dynamic>)) 
        .toList();
        return Right(cardList);
      } else {
        return Left(AppFailure(message: "Invalid response format"));
      }
  }
}


