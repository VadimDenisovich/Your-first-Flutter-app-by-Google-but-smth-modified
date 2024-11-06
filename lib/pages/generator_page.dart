import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import '../widgets/big_card.dart';

class GeneratorPage extends StatefulWidget {
  final List<WordPair> favorites;

  GeneratorPage({required this.favorites});

  @override
  State<GeneratorPage> createState() => _GeneratorPageState();
}

class _GeneratorPageState extends State<GeneratorPage> {
  late List<WordPair> favorites;
  late Function toggleFavorites;
  late WordPair current = WordPair.random();

  @override
  void initState() {
    super.initState();
    favorites = widget.favorites;
  }

  void _toggleFavorite() {
    setState(() {
      if (favorites.contains(current)) {
        favorites.remove(current);
      } else {
        favorites.add(current);
      }
    });
  }

  void _getNext() {
    setState(() {
      current = WordPair.random();
    });
  }

  @override
  Widget build(BuildContext context) {
    IconData icon;
    if (favorites.contains(current)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Scaffold(
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      BigCard(pair: current),
      SizedBox(height: 10),
      Row(mainAxisSize: MainAxisSize.min, children: [
        ElevatedButton(
          onPressed: () {
            _toggleFavorite();
          },
          child: Icon(icon, color: Colors.red),
        ),
        SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            _getNext();
          },
          child: Text('Next'),
        )
      ])
    ])));
  }
}
