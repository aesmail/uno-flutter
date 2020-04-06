import 'package:flutter/material.dart';
import 'package:uno/models/uno_card.dart';
import 'package:uno/models/uno_hand.dart';
import 'package:uno/models/uno_player.dart';

class UnoHandWidget extends StatefulWidget {
  UnoHandWidget({Key key, this.player}) : super(key: key);

  final UnoPlayer player;

  @override
  _UnoHandWidgetState createState() => _UnoHandWidgetState();
}

class _UnoHandWidgetState extends State<UnoHandWidget> {
  double _overlap;
  double _currentSpace;
  Size screen;

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size;
    print(this.widget.player.calculateScore());
    return Transform.scale(
      scale: this.widget.player == this.widget.player.hand.game.currentPlayer()
          ? 0.9
          : 0.75,
      child: Container(
        width: getHandWidth(),
        height: getHandHeight(),
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: this.widget.player.hand.game.isGameOver()
              ? [
                  Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    bottom: 0,
                    child: Center(
                      child: Text(
                        "${this.widget.player.name}\n${this.widget.player.roundScore} Points",
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ]
              : _displayCards(),
        ),
      ),
    );
  }

  List<Widget> _displayCards() {
    _resetValues();
    double top, left;
    return this.widget.player.hand.cards.map((card) {
      card.isHidden = this.widget.player.hand.isHidden;
      if (card.hand != null && card.hand.isVertical()) {
        left = shouldRaiseCard(card);
        top = _currentSpace;
      } else {
        left = _currentSpace;
        top = shouldRaiseCard(card);
      }
      var theCard = Positioned(
        left: left,
        top: top,
        child: Draggable<UnoCard>(
          data: card,
          child: card.toWidget(),
          feedback: card.toWidget(),
          ignoringFeedbackSemantics: false,
          childWhenDragging: Container(),
        ),
      );

      _currentSpace += _overlap;
      return theCard;
    }).toList();
  }

  double shouldRaiseCard(UnoCard card) {
    return card.game.canPlayCard(card) && !card.isHidden ? 15 : null;
  }

  void _resetValues() {
    int numberOfCards = this.widget.player.hand.cards.length;
    double handWidth =
        this.widget.player.hand.orientation == HandOrientation.vertical
            ? getHandHeight()
            : getHandWidth();
    _overlap = (handWidth - 75) / numberOfCards;
    if (_overlap > 50) _overlap = 50;
    _currentSpace = 1;
  }

  double getHandWidth() {
    if (this.widget.player.hand.orientation == HandOrientation.horizontal) {
      return screen.width > (525 + 150 + 150) ? 525.0 : screen.width / 2;
    } else {
      return 150.0;
    }
  }

  double getHandHeight() {
    if (this.widget.player.hand.orientation == HandOrientation.vertical) {
      return 420.0;
    } else {
      return 140.0;
    }
  }
}
