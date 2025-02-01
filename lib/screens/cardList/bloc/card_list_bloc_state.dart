part of 'card_list_bloc_bloc.dart';

@immutable
abstract class CardListBlocState {
  const CardListBlocState();

  List<Object> get props=>[];
}

class CardListBlocInitial extends CardListBlocState {}

class CardListBlocLoading extends CardListBlocState {}


class CardListBlocLoaded extends CardListBlocState {
  final List<PokemonCard> pokemonCardList;
  final bool hasMore;

  const CardListBlocLoaded({required this.pokemonCardList,required this.hasMore});

  @override
  List<Object> get props=>[];
}

class CardListBlocError extends CardListBlocState{
  final String message;

  const CardListBlocError({required this.message});

}
