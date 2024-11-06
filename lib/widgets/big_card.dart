import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class BigCard extends StatelessWidget {
  BigCard(
      {super.key,
      required this.pair,
      this.isEmpty = false,
      this.isFull = false});

  final WordPair pair;
  final bool isEmpty;
  final bool isFull;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var color = theme.colorScheme.onPrimary;
    final style = theme.textTheme.displayMedium!.copyWith(
      color: color,
    );

    return Card(
      color: (isEmpty || isFull) ? Colors.grey : theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          pair.asPascalCase,
          style: style,
          semanticsLabel: "${pair.first} ${pair.second}",
        ),
      ),
    );
  }
}
