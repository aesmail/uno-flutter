import 'package:flutter/material.dart';
import 'package:uno/models/uno_card.dart';
import 'package:uno/models/uno_hand.dart';

class UnoHandWidget extends StatefulWidget {
  UnoHandWidget({Key key, this.hand}) : super(key: key);

  final UnoHand hand;

  @override
  _UnoHandWidgetState createState() => _UnoHandWidgetState();
}

class _UnoHandWidgetState extends State<UnoHandWidget> {
  double _overlap;
  double _currentSpace;
  UnoHand _hand;
  Size screen;

  @override
  initState() {
    super.initState();
    _hand = this.widget.hand;
  }

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size;
    return Transform.scale(
      scale: this._hand.player == this._hand.game.currentPlayer() ? 0.9 : 0.75,
      child: Container(
        width: getHandWidth(),
        height: getHandHeight(),
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: _displayCards(),
        ),
      ),
    );
  }

  List<Widget> _displayCards() {
    _resetValues();
    double top, left;
    return _hand.cards.map((card) {
      card.isHidden = _hand.isHidden;
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
    int numberOfCards = _hand.cards.length;
    _currentSpace = 1;
    double handWidth = _hand.orientation == HandOrientation.vertical
        ? getHandHeight()
        : getHandWidth();
    _overlap = (handWidth - 75) / numberOfCards;
    if (_overlap > 75) _overlap = 75;
  }

  double getHandWidth() {
    if (_hand.orientation == HandOrientation.horizontal) {
      return screen.width > (525 + 150 + 150) ? 525.0 : screen.width / 2;
    } else {
      return 150.0;
    }
  }

  double getHandHeight() {
    if (_hand.orientation == HandOrientation.vertical) {
      return 420.0;
    } else {
      return 140.0;
    }
  }
}
