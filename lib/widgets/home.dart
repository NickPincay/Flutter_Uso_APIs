import 'dart:convert';
import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_uso_apis/models/character.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<Character>> _getCharacter() async {
    final response =
        await http.get(Uri.parse('https://dragonball-api.com/api/characters'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> items = data['items'];

      return items
          .map((item) => Character(
                name: item['name'],
                image: item['image'],
                race: item['race'],
              ))
          .toList();
    } else {
      throw Exception('Error de conexión');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/fondo-home.png',
              fit: BoxFit.cover,
            ),
          ),
          FutureBuilder<List<Character>>(
            future: _getCharacter(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final characters = snapshot.data!;
                final random = Random();
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: MasonryGridView.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    itemCount: characters.length,
                    itemBuilder: (context, index) {
                      final character = characters[index];
                      if (index == 1) {
                        return Column(
                          children: [
                            const SizedBox(height: 20),
                            _Character(random: random, character: character)
                          ],
                        );
                      }
                      return _Character(random: random, character: character);
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class _Character extends StatelessWidget {
  const _Character({
    required this.random,
    required this.character,
  });

  final Random random;
  final Character character;

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      from: random.nextInt(100) + 80,
      delay: Duration(milliseconds: random.nextInt(450) + 0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Colors.red.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              child: FadeInImage(
                height: 150,
                fit: BoxFit.scaleDown,
                placeholder: const AssetImage('assets/images/placeholder.gif'),
                image: NetworkImage(character.image),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    character.name,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontFamily: 'Saiyan-Sans',
                    ),
                  ),
                  Text(
                    character.race,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
