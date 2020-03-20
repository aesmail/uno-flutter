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

  @override
  initState() {
    super.initState();
    _hand = this.widget.hand;
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    if (this._hand == this._hand.game.currentHand()) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.white, width: 2.0),
        ),
        width: getHandWidth(screen),
        height: getHandHeight(screen),
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: _displayCards(screen),
        ),
      );
    } else {
      return Container(
        width: getHandWidth(screen),
        height: getHandHeight(screen),
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: _displayCards(screen),
        ),
      );
    }
  }

  List<Widget> _displayCards(Size screen) {
    _resetValues(screen);
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

  void _resetValues(Size screen) {
    int numberOfCards = _hand.cards.length;
    _currentSpace = 1;
    double handWidth = getHandWidth(screen) == null
        ? getHandHeight(screen)
        : getHandWidth(screen);
    _overlap = (handWidth - 75) / numberOfCards;
  }

  double getHandWidth(screen) {
    if (_hand.orientation == HandOrientation.horizontal) {
      return screen.width / 2;
    }
    return null;
  }

  double getHandHeight(screen) {
    if (_hand.orientation == HandOrientation.vertical) {
      return screen.height / 2;
    }
    return null;
  }
}
