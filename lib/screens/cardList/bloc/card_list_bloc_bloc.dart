import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta/meta.dart';
import 'package:pokemon_gravity/core/server/webservice.dart';
import 'package:pokemon_gravity/screens/cardList/repository/card_list_repository.dart';
import 'package:pokemon_gravity/model/pokemon_card.dart';

part 'card_list_bloc_event.dart';
part 'card_list_bloc_state.dart';

class CardListBlocBloc extends Bloc<CardListBlocEvent, CardListBlocState> {
  final CardListRepository cardListRepository;
  int currentPage = 1;
  bool isFetching = false;
  List<PokemonCard> pokemonCardList = [];

  CardListBlocBloc({required this.cardListRepository})
      : super(CardListBlocLoading()) {
    on<CardListBlocLoadEvent>(cardListStatetoEvent);
    on<CardListBlocSearchEvent>(cardListSearchStatetoEvent);
  }

  cardListStatetoEvent(
      CardListBlocLoadEvent event, Emitter<CardListBlocState> emit) async {
    //returns if already fetching
    if (isFetching) return;

    isFetching = true;

    final currentState = state;
    bool isInitialLoad = pokemonCardList.isEmpty;
    if (currentState is CardListBlocLoaded) {
      pokemonCardList = List.from(currentState.pokemonCardList);
    }

    if (isInitialLoad) {
      emit(CardListBlocLoading());
    } else {
      emit(CardListBlocLoaded(pokemonCardList: pokemonCardList, hasMore: true));
    }

    try {
      final result = await cardListRepository.getCardList(event.page);
      result.fold(
        (error) => emit(CardListBlocError(message: error.toString())),
        (newCards) => cardPagination(newCards, emit),
      );
    } catch (e) {
      emit(CardListBlocError(message: e.toString()));
    }

    isFetching = false;
  }

  // Handle Pagination adds newly fetch cards to list
  cardPagination(
    List<PokemonCard> newCards,
    Emitter<CardListBlocState> emit,
  ) {
    pokemonCardList.addAll(newCards);

    emit(CardListBlocLoaded(
      pokemonCardList: pokemonCardList,
      hasMore: newCards.isNotEmpty,
    ));

    currentPage++;
  }

//this is used for search cards
  cardListSearchStatetoEvent(
      CardListBlocSearchEvent event, Emitter<CardListBlocState> emit) async {
    emit(CardListBlocLoading());
    try {
      final result = await cardListRepository.getSearchCardList(event.query);

      result.fold((l) => emit(CardListBlocError(message: l.toString())),
          (r) => emit(CardListBlocLoaded(pokemonCardList: r, hasMore: false)));
    } catch (e) {
      emit(CardListBlocError(message: e.toString()));
    }
  }
}
