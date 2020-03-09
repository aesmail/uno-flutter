import 'package:flutter/material.dart';
import 'package:uno/widgets/uno_card.dart';

class UnoDeck extends StatefulWidget {
  const UnoDeck({Key key}) : super(key: key);

  @override
  _UnoDeckState createState() => _UnoDeckState();
}

class _UnoDeckState extends State<UnoDeck> {
  List<UnoCard> _deck;
  List<UnoCard> _currentHand;
  double _overlap;
  double _currentSpace;

  @override
  initState() {
    super.initState();
    initializeDeck();
    shuffleDeck();
    setCurrentHand();
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
    return _currentHand.map((card) {
      GlobalKey _myKey = new GlobalKey();
      var theCard = Positioned(
        key: _myKey,
        left: _currentSpace,
        child: Draggable<UnoCard>(
          data: card,
          child: card,
          feedback: card,
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
      _currentHand.add(_deck.first);
      _deck.removeAt(0);
    });
  }

  void _resetValues() {
    _currentSpace = 5;
    _overlap = 40;
  }

  List<UnoCard> setCurrentHand() {
    _currentHand = drawCards(7);
    return _currentHand;
  }

  List<UnoCard> drawCards(int cardCount) {
    _currentHand = _deck.sublist(0, cardCount);
    _deck.removeRange(0, cardCount);
    return _currentHand;
  }

  List<UnoCard> shuffleDeck() {
    _deck.shuffle();
    return _deck;
  }

  void initializeDeck() {
    _deck = [
      UnoCard(symbol: "0", color: Colors.red),
      UnoCard(symbol: "1", color: Colors.red),
      UnoCard(symbol: "2", color: Colors.red),
      UnoCard(symbol: "3", color: Colors.red),
      UnoCard(symbol: "4", color: Colors.red),
      UnoCard(symbol: "5", color: Colors.red),
      UnoCard(symbol: "6", color: Colors.red),
      UnoCard(symbol: "7", color: Colors.red),
      UnoCard(symbol: "8", color: Colors.red),
      UnoCard(symbol: "9", color: Colors.red),
      UnoCard(symbol: "0", color: Colors.blue),
      UnoCard(symbol: "1", color: Colors.blue),
      UnoCard(symbol: "2", color: Colors.blue),
      UnoCard(symbol: "3", color: Colors.blue),
      UnoCard(symbol: "4", color: Colors.blue),
      UnoCard(symbol: "5", color: Colors.blue),
      UnoCard(symbol: "6", color: Colors.blue),
      UnoCard(symbol: "7", color: Colors.blue),
      UnoCard(symbol: "8", color: Colors.blue),
      UnoCard(symbol: "9", color: Colors.blue),
      UnoCard(symbol: "0", color: Colors.yellow),
      UnoCard(symbol: "1", color: Colors.yellow),
      UnoCard(symbol: "2", color: Colors.yellow),
      UnoCard(symbol: "3", color: Colors.yellow),
      UnoCard(symbol: "4", color: Colors.yellow),
      UnoCard(symbol: "5", color: Colors.yellow),
      UnoCard(symbol: "6", color: Colors.yellow),
      UnoCard(symbol: "7", color: Colors.yellow),
      UnoCard(symbol: "8", color: Colors.yellow),
      UnoCard(symbol: "9", color: Colors.yellow),
      UnoCard(symbol: "0", color: Colors.green),
      UnoCard(symbol: "1", color: Colors.green),
      UnoCard(symbol: "2", color: Colors.green),
      UnoCard(symbol: "3", color: Colors.green),
      UnoCard(symbol: "4", color: Colors.green),
      UnoCard(symbol: "5", color: Colors.green),
      UnoCard(symbol: "6", color: Colors.green),
      UnoCard(symbol: "7", color: Colors.green),
      UnoCard(symbol: "8", color: Colors.green),
      UnoCard(symbol: "9", color: Colors.green),
    ];
  }
}
