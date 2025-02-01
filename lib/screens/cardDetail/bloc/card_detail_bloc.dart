import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pokemon_gravity/model/pokemon_card.dart';
import 'package:pokemon_gravity/screens/cardDetail/repository/card_detail_repository.dart';

part 'card_detail_event.dart';
part 'card_detail_state.dart';

class CardDetailBloc extends Bloc<CardDetailEvent, CardDetailState> {
  CardDetailRepository cardDetailRepository;
  CardDetailBloc({required this.cardDetailRepository})
      : super(CardDetailLoading()) {
    on<CardDetailLoadEvent>(_cardDetailStatetoEvent);
  }

  _cardDetailStatetoEvent(
      CardDetailLoadEvent event, Emitter<CardDetailState> emit) async {
    emit(CardDetailLoading());
    try {
      final result = await cardDetailRepository.getCardDetail(event.id);
      result.fold((l) => emit(CardDetailError(message: l.toString())),
          (r) => emit(CardDetailLoaded(pokemonCard: r)));
    } catch (e) {
      emit(CardDetailError(message: e.toString()));
    }
  }
}
