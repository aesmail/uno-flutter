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
    initGame();
  }

  void initGame() {
    game = UnoGame();
    game.prepareGame();
    game.playTurn(this);
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
        if (game.needsColorDecision()) {
        } else {
          game.playTurn(this);
          this.setState(() {});
        }
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
          child: Column(
            children: [
              Text("Game Over!", style: TextStyle(fontSize: 30)),
              FlatButton(
                child:
                    Text("Play again", style: TextStyle(color: Colors.white)),
                onPressed: () {
                  this.setState(() {
                    initGame();
                  });
                },
              ),
            ],
          ),
        ),
      );
    } else {
      return Row(
        children: [
          Expanded(child: Center(child: game.currentCard().toWidget())),
          Expanded(
            child: Center(
              child: game.needsColorDecision()
                  ? Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              FlatButton(
                                  color: Colors.green,
                                  child: Text("Green"),
                                  onPressed: () {
                                    game.setColor(CardColor.green);
                                    this.setState(() {});
                                  }),
                              FlatButton(
                                  color: Colors.red,
                                  child: Text("Red"),
                                  onPressed: () {
                                    game.setColor(CardColor.red);
                                    this.setState(() {});
                                  }),
                            ],
                          ),
                          Row(
                            children: [
                              FlatButton(
                                  color: Colors.blue,
                                  child: Text("blue"),
                                  onPressed: () {
                                    game.setColor(CardColor.blue);
                                    this.setState(() {});
                                  }),
                              FlatButton(
                                  color: Colors.yellow,
                                  child: Text("Yellow"),
                                  onPressed: () {
                                    game.setColor(CardColor.yellow);
                                    this.setState(() {});
                                  }),
                            ],
                          )
                        ],
                      ),
                    )
                  : GestureDetector(
                      child: game.deck.toWidget(),
                      onTap: () {
                        game.drawCardFromDeck();
                        game.playTurn(this);
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
