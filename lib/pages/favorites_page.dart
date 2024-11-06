import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import '../widgets/big_card.dart';

class FavoritesPage extends StatefulWidget {
  final List<WordPair> favorites;

  FavoritesPage({required this.favorites});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late List<WordPair> favorites;
  var index = 0;
  bool isEmpty = false;
  bool isFull = false;
  var actual;
  IconData icon = Icons.favorite;
  Widget nextButton = Container();
  Widget likeButton = Container();
  Widget backButton = Container();
  late Widget gNextButton;
  late Widget gLikeButton;

  @override
  void initState() {
    super.initState();
    favorites = widget.favorites;

    gNextButton = ElevatedButton(
        onPressed: () {
          index += 1;
          _updateActual();
        },
        child: Text('Next'));

    gLikeButton = ElevatedButton(
        onPressed: () {
          _deleteFavorite();
          _updateActual();
        },
        child: Icon(icon, color: Colors.red));

    if (favorites.isEmpty) {
      isEmpty = true;
      actual = WordPair('Ничего', " Нет");
    } else {
      actual = favorites[0];
      nextButton = gNextButton;
      likeButton = gLikeButton;
    }
  }

  Widget _createBackButton() {
    return ElevatedButton(
        onPressed: () {
          _toStart();
        },
        child: Icon(Icons.arrow_back));
  }

  void _toStart() {
    setState(() {
      index = 0;
      _updateActual();
      backButton = Container();
      isFull = false;
      nextButton = gNextButton;
      likeButton = gLikeButton;
    });
  }

  void _deleteFavorite() {
    setState(() {
      favorites.remove(actual);
    });
  }

  void _updateActual() {
    setState(() {
      if (index < favorites.length) {
        actual = favorites[index];
        isFull = false;
      } else {
        if (favorites.isEmpty) {
          actual = WordPair('Ничего', ' Нет');
          isEmpty = true;
        } else {
          actual = WordPair('дальше', ' Нет');
          isFull = true;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isFull || isEmpty) {
      nextButton = Container();
      likeButton = Container();
    }

    if (index > 0) {
      backButton = _createBackButton();
    }

    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BigCard(pair: actual, isEmpty: isEmpty, isFull: isFull),
        SizedBox(height: 10),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            likeButton,
            SizedBox(
              width: 10,
            ),
            nextButton,
            SizedBox(width: 10),
            backButton
          ],
        )
      ],
    )));
  }
}
