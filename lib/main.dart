import 'package:flutter/material.dart';
import 'package:uno/widgets/uno_game_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Uno',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: UnoGameWidget(title: "Uno Flutter"),
    );
  }
}
