import 'package:flutter/material.dart';
import 'package:uno/models/uno_hand.dart';
import 'package:uno/widgets/uno_card_widget.dart';

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
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: _displayCards(),
      ),
    );
  }

  List<Widget> _displayCards() {
    _resetValues();
    return _hand.cards.map((card) {
      var cardWidget = card.toWidget();
      var theCard = Positioned(
        left: _currentSpace,
        child: Draggable<UnoCardWidget>(
          data: cardWidget,
          child: cardWidget,
          feedback: cardWidget,
          ignoringFeedbackSemantics: false,
          childWhenDragging: Container(),
        ),
      );

      _currentSpace += _overlap;
      return theCard;
    }).toList();
  }

  void _resetValues() {
    _currentSpace = 5;
    _overlap = 40;
  }
}
