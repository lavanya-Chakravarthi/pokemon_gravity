part of 'card_detail_bloc.dart';

@immutable
abstract class CardDetailEvent {}

class CardDetailLoadEvent extends CardDetailEvent{
  final String id;

  CardDetailLoadEvent({required this.id});
}
