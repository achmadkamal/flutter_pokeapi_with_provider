import 'package:flutter/material.dart';
import 'package:flutter_pokeapi_with_provider/widget/pokemon_widget.dart';
import 'package:flutter_pokeapi_with_provider/screen/pokemon_screen.dart';
import 'package:flutter_pokeapi_with_provider/state_manager/pokemon_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        context.read<PokemonProvider>().getMorePokemons();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red.shade900,
        title: const Text(
          'Pokedex',
          style: TextStyle(color: Colors.yellow),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: context.read<PokemonProvider>().getPokemons(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Consumer<PokemonProvider>(
              builder: (context, pokemon, _) => GridView.count(
                padding: const EdgeInsets.all(20),
                controller: _scrollController,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                crossAxisCount: 2,
                childAspectRatio: 1.5,
                children: pokemon.pokemonsDetail
                    .map(
                      (pokemon) => PokemonWidget(
                        pokemon: pokemon,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PokemonScreen(pokemon: pokemon),
                            ),
                          );
                        },
                      ),
                    )
                    .toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
