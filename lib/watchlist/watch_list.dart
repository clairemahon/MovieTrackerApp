import 'package:flutter/material.dart';

class WatchList extends StatefulWidget {
  const WatchList({Key? key}) : super(key: key);

  // TODO 1
  @override
  State<WatchList> createState() => _WatchListState();
}

class _WatchListState extends State<WatchList> {
  final checkBoxValues = <int, bool>{};
  static const ingredients = <String>[];

  @override
  Widget build(BuildContext context) {
    // TODO 2
    return ListView.builder(
        itemCount: ingredients.length,
        itemBuilder: (BuildContext context, int index) {
          return CheckboxListTile(
            value: checkBoxValues.containsKey(index) && checkBoxValues[index]!,
            // TODO 3
            title: Text(ingredients[index]),
            onChanged: (newValue) {
              if (newValue != null) {
                setState(() {
                  checkBoxValues[index] = newValue;
                });
              }
            },
          );
        });
    // TODO 4
  }
}
