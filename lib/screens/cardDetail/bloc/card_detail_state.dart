part of 'card_detail_bloc.dart';

@immutable
abstract class CardDetailState {}

class CardDetailLoading extends CardDetailState {}
class CardDetailLoaded extends CardDetailState {
  final PokemonCard pokemonCard;

  CardDetailLoaded({required this.pokemonCard});
}

class CardDetailError extends CardDetailState {
  final String message;
  CardDetailError({required this.message});
}
