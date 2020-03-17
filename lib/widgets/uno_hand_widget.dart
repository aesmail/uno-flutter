import 'package:flutter/material.dart';
import 'package:uno/models/uno_card.dart';
import 'package:uno/models/uno_hand.dart' as unoHand;

class UnoHandWidget extends StatefulWidget {
  UnoHandWidget({Key key, this.hand}) : super(key: key);

  final unoHand.UnoHand hand;

  @override
  _UnoHandWidgetState createState() => _UnoHandWidgetState();
}

class _UnoHandWidgetState extends State<UnoHandWidget> {
  double _overlap;
  double _currentSpace;
  unoHand.UnoHand _hand;

  @override
  initState() {
    super.initState();
    _hand = this.widget.hand;
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
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

  List<Widget> _displayCards(Size screen) {
    _resetValues(screen);
    double top, left;
    return _hand.cards.map((card) {
      card.isHidden = _hand.isHidden;
      if (card.hand != null && card.hand.isVertical()) {
        left = this._hand.game.canPlayCard(card) ? 15 : null;
        top = _currentSpace;
      } else {
        left = _currentSpace;
        top = this._hand.game.canPlayCard(card) ? 15 : null;
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

  void _resetValues(Size screen) {
    int numberOfCards = _hand.cards.length;
    _currentSpace = 1;
    double handWidth = getHandWidth(screen) == null
        ? getHandHeight(screen)
        : getHandWidth(screen);
    _overlap = (handWidth - 75) / numberOfCards;
  }

  double getHandWidth(screen) {
    if (_hand.orientation == unoHand.Orientation.horizontal) {
      return screen.width / 2;
    }
    return null;
  }

  double getHandHeight(screen) {
    if (_hand.orientation == unoHand.Orientation.vertical) {
      return screen.height / 2;
    }
    return null;
  }
}
