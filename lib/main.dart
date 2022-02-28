import 'package:flutter/material.dart';
import 'package:flutter_pokeapi_with_provider/home_page.dart';
import 'package:flutter_pokeapi_with_provider/state_manager/pokemon_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PokemonProvider>(
          create: (_) => PokemonProvider(),
        )
      ],
      child: const MaterialApp(home: HomePage()),
    );
  }
}
