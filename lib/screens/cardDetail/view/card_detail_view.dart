import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_gravity/core/theme/theme.dart';
import 'package:pokemon_gravity/core/widgets/snackbar.dart';
import 'package:pokemon_gravity/core/widgets/text_widget.dart';
import 'package:pokemon_gravity/model/pokemon_card.dart';
import 'package:pokemon_gravity/screens/cardDetail/bloc/card_detail_bloc.dart';
import 'package:pokemon_gravity/screens/cardDetail/repository/card_detail_repository.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../core/widgets/loader.dart';

class CardDetailScreen extends StatefulWidget {
  final String id;

  const CardDetailScreen({super.key, required this.id});

  @override
  State<CardDetailScreen> createState() => _CardDetailScreenState();
}

class _CardDetailScreenState extends State<CardDetailScreen> {
  //id is passed on navigation and hits api search for particular card details
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CardDetailBloc(cardDetailRepository: CardDetailRepository())
            ..add(CardDetailLoadEvent(id: widget.id)),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeColor.appBarColor,
          title: BlocBuilder<CardDetailBloc, CardDetailState>(
            builder: (context, state) {
              if (state is CardDetailLoaded) {
                return customText(
                  strText: state.pokemonCard.name!,
                  size: 18,
                  weight: FontWeight.bold,
                );
              }

              return const customText(strText: "");
            },
          ),
        ),
        backgroundColor: Colors.grey[350],
        body: BlocConsumer<CardDetailBloc, CardDetailState>(
          listener: (context, state) {
            if (state is CardDetailError) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showSnackbar(context, state.message.toString());
              });
            }
          },
          builder: (context, state) {
            if (state is CardDetailLoading) {
              return const Center(child: Loader());
            } else if (state is CardDetailLoaded) {
              print(state.pokemonCard);
              return cardDetailData(state.pokemonCard);
            } else {
              return const Center(child: customText(strText: "No data found"));
            }
          },
        ),
      ),
    );
  }

// this is list of card details with animation effects
  Widget cardDetailData(PokemonCard pokemonCard) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: AnimateList(
            interval: 200.ms,
            effects: [
              FadeEffect(duration: 900.ms, delay: 300.ms),
              const ShimmerEffect(
                  blendMode: BlendMode.srcOver, color: Colors.white12),
              const MoveEffect(
                  begin: const Offset(-16, 0), curve: Curves.easeOutQuad)
            ],
            children: [
              CachedNetworkImage(
                imageUrl: pokemonCard.images!.large! ?? '',
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              const SizedBox(height: 16),
              customText(
                strText: pokemonCard.name!,
                size: 24,
                weight: FontWeight.bold,
              ),
              const SizedBox(height: 8),
              customText(strText: 'SuperType: ${pokemonCard.supertype}'),
              const SizedBox(height: 8),
              customText(
                  strText: 'SubTypes: ${pokemonCard.subtypes!.join(', ')}'),
              const SizedBox(height: 16),
              customText(
                  strText:
                      'Set: ${pokemonCard.set!.name} (${pokemonCard.set!.releaseDate})'),
              const SizedBox(height: 8),
              SizedBox(
                height: 100,
                width: 100,
                child: CachedNetworkImage(
                  imageUrl: pokemonCard.set!.images!.logo ?? '',
                  placeholder: (context, url) => const SizedBox(
                      height: 100,
                      width: 100,
                      child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              const SizedBox(height: 8),
              customText(strText: 'Series: ${pokemonCard.set!.series}'),
              const SizedBox(height: 8),
              const customText(
                strText: "Attacks",
                size: 18,
                weight: FontWeight.bold,
              ),
              ...pokemonCard.attacks!
                  .map<Widget>((attack) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customText(
                              strText: 'Cost: ${attack.cost!.join(', ')}'),
                          Text('Damage: ${attack.damage}'),
                          Text('Effect: ${attack.text}'),
                          const SizedBox(height: 8),
                        ],
                      ))
                  .toList(),
              const SizedBox(height: 16),
              if (pokemonCard.weaknesses!.isNotEmpty)
                Text(
                    'Weakness: ${pokemonCard.weaknesses![0].type} [${pokemonCard.weaknesses![0].value}]'),
              const SizedBox(height: 8),
              if (pokemonCard.resistances!.isNotEmpty)
                Text(
                    'Resistances: ${pokemonCard.resistances![0].type} [${pokemonCard.resistances![0].value}]'),
              const SizedBox(height: 8),
              if (pokemonCard.retreatCost!.isNotEmpty)
                Text('Retreat Cost: ${pokemonCard.retreatCost!.join(', ')}'),
              const SizedBox(height: 16),
              customText(strText: 'Artist: ${pokemonCard.artist}'),
              const SizedBox(height: 8),
              customText(strText: 'Rarity: ${pokemonCard.rarity}'),
              const SizedBox(height: 8),
              customText(strText: 'Flavour Text: ${pokemonCard.flavorText}'),
              const SizedBox(height: 16),
              const customText(
                strText: 'Price (TCGPlayer)',
                size: 18,
                weight: FontWeight.bold,
              ),
              const SizedBox(height: 8),
              customText(
                  strText:
                      'Low: ${pokemonCard.tcgplayer!.prices!.holofoil!.low}'),
              const SizedBox(height: 8),
              customText(
                  strText:
                      'Mid: ${pokemonCard.tcgplayer!.prices!.holofoil!.mid}'),
              const SizedBox(height: 8),
              customText(
                  strText:
                      'High: ${pokemonCard.tcgplayer!.prices!.holofoil!.high}'),
              const SizedBox(height: 16),
              const customText(
                strText: 'Price (CardMarket)',
                size: 18,
                weight: FontWeight.bold,
              ),
              const SizedBox(height: 8),
              customText(
                  strText:
                      'Average sell price: ${pokemonCard.cardmarket!.prices!.averageSellPrice}'),
              const SizedBox(height: 8),
              customText(
                  strText:
                      'Trend Price: ${pokemonCard.cardmarket!.prices!.trendPrice}'),
            ],
          ),
        ),
      ),
    );
  }
}
