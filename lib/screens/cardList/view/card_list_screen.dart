import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_gravity/core/routes/route_constants.dart';
import 'package:pokemon_gravity/core/theme/theme.dart';
import 'package:pokemon_gravity/core/widgets/loader.dart';
import 'package:pokemon_gravity/core/widgets/snackbar.dart';
import 'package:pokemon_gravity/core/widgets/text_widget.dart';
import 'package:pokemon_gravity/screens/cardDetail/view/card_detail_view.dart';
import 'package:pokemon_gravity/screens/cardList/repository/card_list_repository.dart';
import 'package:pokemon_gravity/model/pokemon_card.dart';
import '../bloc/card_list_bloc_bloc.dart';

class CardListScreen extends StatefulWidget {
  const CardListScreen({super.key});

  @override
  State<CardListScreen> createState() => _CardListScreenState();
}

class _CardListScreenState extends State<CardListScreen> {
  final CardListRepository cardListRepository = CardListRepository();
  late ScrollController _scrollController;
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(onScroll);
  }

// this is used when page hits at the end of data, will hit api to get more data for next page
  void onScroll() {
    if (!_isSearching) {
      final bloc = context.read<CardListBlocBloc>();

      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 100 &&
          !bloc.isFetching) {
        bloc.add(CardListBlocLoadEvent(page: bloc.currentPage));
      }
    }
  }

// this used to toggle search field
  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
      }
    });
  }

  searchPokemon() async {
    final bloc = context.read<CardListBlocBloc>();
    final query = _searchController.text;

    if (query.isNotEmpty) {
      // delays api hit to reduce multiple hits at a time
      Future.delayed(const Duration(milliseconds: 1000), () {
        bloc.add(CardListBlocSearchEvent(query: query));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColor.appBarColor,
        title: _isSearching
            ? TextField(
                // this expandable on appbar to search cards by name
                controller: _searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Search by name',
                  border: InputBorder.none,
                ),
                onChanged: (query) => searchPokemon(),
              )
            : const Center(
                child: customText(
                  strText: "Pokemon",
                  weight: FontWeight.bold,
                  size: 18,
                ),
              ),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: _toggleSearch,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => super.widget),
              (route) => false);
        },
        child: BlocListener<CardListBlocBloc, CardListBlocState>(
          listener: (context, state) {
            if (state is CardListBlocError) {
              // Show snackbar on error state
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showSnackbar(context, state.message.toString());
              });
            }
          },
          child: BlocBuilder<CardListBlocBloc, CardListBlocState>(
            builder: (context, state) {
              return cardList(context, state);
            },
          ),
        ),
      ),
    );
  }

  // CardList widget to display based on the state
  cardList(BuildContext context, Object? state) {
    if (state is CardListBlocLoading) {
      return const Center(child: Loader());
    } else if (state is CardListBlocLoaded) {
      return state.pokemonCardList.isNotEmpty
          ? listView(context, state)
          : const Center(
              child: customText(strText: "No data found"),
            );
    } else if (state is CardListBlocError) {
      return const Center(
        child: customText(strText: "No data found"),
      );
    }
  }

//this is show grid view of cards with 2 columns
  listView(BuildContext context, CardListBlocLoaded state) {
    return GridView.builder(
      controller: _scrollController,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
      ),
      itemCount: state is CardListBlocLoaded ? state.pokemonCardList.length : 0,
      itemBuilder: (context, index) {
        if (state is CardListBlocLoaded) {
          return _buildCard(state.pokemonCardList[index]);
        }
        return const SizedBox.shrink();
      },
    );
  }

// cards ui
  Widget _buildCard(PokemonCard card) {
    return Card(
      color: ThemeColor.cardColor,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: InkWell(
          onTap: () {
            if (card.id != null) {
              Navigator.pushNamed(context, RouteConstants.rCardDetailScreen,
                  arguments: card.id);
            }
          },
          child: Column(
            children: [
              Expanded(
                child: CachedNetworkImage(
                  imageUrl: card.images!.small!,
                  placeholder: (context, url) => const SizedBox(
                    width: 50,
                    height: 50,
                    child: Center(
                      child: Loader(),
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  // width: 200,
                  // height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              // Expanded(child: Image.network(card.images.small, fit: BoxFit.cover)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(card.name!, style: const TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
