import 'package:flutter/material.dart';
import 'models/uno_card.dart';
import 'models/uno_game.dart';

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
      home: MyHomePage(title: 'Uno Flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  UnoGame game;

  @override
  initState() {
    super.initState();
    game = UnoGame();
    game.prepareGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[300],
      body: Center(
        child: Row(
          children: [
            Expanded(child: game.hands[1].toWidget()),
            Column(
              children: [
                Expanded(child: game.hands[2].toWidget()),
                playTable(context),
                Expanded(child: game.hands[0].toWidget()),
              ],
            ),
            Expanded(child: game.hands[3].toWidget()),
          ],
        ),
      ),
    );
  }

  Widget playTable(context) {
    Size screen = MediaQuery.of(context).size;
    return DragTarget<UnoCard>(
      onWillAccept: (UnoCard card) {
        return game.canPlayCard(card);
      },
      onAccept: (UnoCard card) {
        game.playCard(card);
        game.isGameOver();
        this.setState(() {});
      },
      builder: (context, list1, list2) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            color: Colors.blue[900],
          ),
          height: 120,
          width: screen.width / 2,
          child: playArea(),
        );
      },
    );
  }

  Widget playArea() {
    if (game.isGameOver()) {
      return Container(
        child: Center(
          child: Text("Game Over!", style: TextStyle(fontSize: 40)),
        ),
      );
    } else {
      return Row(
        children: [
          Expanded(child: Center(child: game.thrown.last.toWidget())),
          Expanded(
            child: Center(
              child: GestureDetector(
                child: game.deck.toWidget(),
                onTap: () {
                  game.drawCardFromDeck();
                  this.setState(() {});
                },
              ),
            ),
          ),
        ],
      );
    }
  }
}
