import 'package:flutter/material.dart';
import 'package:uno/models/uno_card.dart';
import 'package:uno/models/uno_game.dart';

class UnoGameWidget extends StatefulWidget {
  UnoGameWidget({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _UnoGameWidgetState createState() => _UnoGameWidgetState();
}

class _UnoGameWidgetState extends State<UnoGameWidget> {
  UnoGame game;

  @override
  initState() {
    super.initState();
    initGame();
  }

  void initGame() {
    game = null;
    game = UnoGame();
    game.prepareGame();
    game.playTurn(this);
    this.setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[300],
      body: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Container(
          height: 460,
          width: 880,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.topCenter,
                // color: Colors.brown,
                child: game.players[1].hand.toWidget(),
              ),
              Column(
                children: [
                  game.players[2].hand.toWidget(),
                  playTable(context),
                  game.players[0].hand.toWidget(),
                ],
              ),
              Container(
                alignment: Alignment.topCenter,
                // color: Colors.cyan,
                child: game.players[3].hand.toWidget(),
              ),
            ],
          ),
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
        if (game.playCard(card)) {
          game.playTurn(this);
        }
        this.setState(() {});
      },
      builder: (context, list1, list2) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            color: game.getPlayingColor(),
          ),
          height: 120,
          width: screen.width > (525 + 150 + 150) ? 525.0 : screen.width / 2,
          child: playArea(),
        );
      },
    );
  }

  Widget playArea() {
    if (game.isGameOver()) {
      return gameOverWidget();
    } else {
      return cardsAndDeck();
    }
  }

  Widget colorChoice(String title, Color color, CardColor cardColor) {
    return SizedBox(
      width: 75,
      child: FlatButton(
        color: color,
        child: Text(title),
        onPressed: () {
          print("Human chose: $cardColor");
          game.setColor(cardColor);
          game.playTurn(this);
          this.setState(() {});
        },
      ),
    );
  }

  Widget gameOverWidget() {
    return Container(
      child: Center(
        child: Column(
          children: [
            Text("Game Over!",
                style: TextStyle(fontSize: 30, color: Colors.white)),
            FlatButton(
              child: Text("Play again", style: TextStyle(color: Colors.white)),
              onPressed: () {
                initGame();
                this.setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget cardsAndDeck() {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
              ),
              color: Colors.black,
            ),
            child: Center(
              child: game.currentCard().toWidget(),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: game.needsColorDecision()
                ? Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            colorChoice("Red", Colors.red, CardColor.red),
                            colorChoice("Blue", Colors.blue, CardColor.blue),
                          ],
                        ),
                        Row(
                          children: [
                            colorChoice(
                                "Yellow", Colors.yellow, CardColor.yellow),
                            colorChoice("Green", Colors.green, CardColor.green),
                          ],
                        )
                      ],
                    ),
                  )
                : GestureDetector(
                    child: Container(
                      child: game.deck.toWidget(),
                    ),
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
