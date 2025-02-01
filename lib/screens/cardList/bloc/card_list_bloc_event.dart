part of 'card_list_bloc_bloc.dart';

@immutable
abstract class CardListBlocEvent {}

class CardListBlocLoadEvent extends CardListBlocEvent{
  final int page;
  CardListBlocLoadEvent({required this.page});
  
}

class CardListBlocSearchEvent extends CardListBlocEvent{
  final String query;
  CardListBlocSearchEvent({required this.query});
  
}
