import 'package:flutter/material.dart';
import 'package:uno/models/uno_deck.dart';
import 'package:uno/widgets/uno_card_widget.dart';

class UnoDeckWidget extends StatefulWidget {
  UnoDeckWidget({Key key, this.deck}) : super(key: key);

  final UnoDeck deck;

  @override
  _UnoDeckWidgetState createState() => _UnoDeckWidgetState();
}

class _UnoDeckWidgetState extends State<UnoDeckWidget> {
  double _overlap;
  double _currentSpace;

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
    return this.widget.deck.cards.map((card) {
      UnoCardWidget cardWidget = UnoCardWidget(card: card);
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

  void drawOne() {
    this.setState(() {
      this.widget.deck.dealHand(cardCount: 1);
    });
  }
}
