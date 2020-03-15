import 'package:flutter/material.dart';
import 'package:uno/models/uno_action.dart';
import 'package:uno/models/uno_card.dart';
import 'package:uno/models/uno_hand.dart';

class UnoDeck {
  List<UnoCard> cards = [];

  UnoCard drawCard({bool hide = false}) {
    UnoCard _card = cards.removeLast();
    _card.isHidden = hide;
    return _card;
  }

  void shuffle() => cards.shuffle();

  UnoHand dealHand({int cardCount = 7, bool isHidden = false}) {
    if (cards.length > cardCount) {
      List<UnoCard> _hand = cards.sublist(0, cardCount);
      cards.removeRange(0, cardCount);
      return UnoHand(cards: _hand, isHidden: isHidden);
    }
    return null;
  }

  UnoDeck() {
    UnoAction normalAction =
        UnoAction(value: "0", type: "normal", title: "Normal");
    UnoAction drawTwo = UnoAction(value: "2", type: "draw", title: "Draw 2");
    UnoAction drawFour = UnoAction(
        value: "4", type: "draw", title: "Draw 4", options: ["color"]);
    // UnoAction skipNext = UnoAction(value: "0", type: "skip", title: "Skip");
    // UnoAction switchPlay =
    //     UnoAction(value: "0", type: "switch", title: "Switch");

    cards = [
      UnoCard(symbol: "0", color: Colors.red, value: 0, action: normalAction),
      UnoCard(symbol: "1", color: Colors.red, value: 1, action: normalAction),
      UnoCard(symbol: "2", color: Colors.red, value: 2, action: normalAction),
      UnoCard(symbol: "3", color: Colors.red, value: 3, action: normalAction),
      UnoCard(symbol: "4", color: Colors.red, value: 4, action: normalAction),
      UnoCard(symbol: "5", color: Colors.red, value: 5, action: normalAction),
      UnoCard(symbol: "6", color: Colors.red, value: 6, action: normalAction),
      UnoCard(symbol: "7", color: Colors.red, value: 7, action: normalAction),
      UnoCard(symbol: "8", color: Colors.red, value: 8, action: normalAction),
      UnoCard(symbol: "9", color: Colors.red, value: 9, action: normalAction),
      UnoCard(symbol: "0", color: Colors.blue, value: 0, action: normalAction),
      UnoCard(symbol: "1", color: Colors.blue, value: 1, action: normalAction),
      UnoCard(symbol: "2", color: Colors.blue, value: 2, action: normalAction),
      UnoCard(symbol: "3", color: Colors.blue, value: 3, action: normalAction),
      UnoCard(symbol: "4", color: Colors.blue, value: 4, action: normalAction),
      UnoCard(symbol: "5", color: Colors.blue, value: 5, action: normalAction),
      UnoCard(symbol: "6", color: Colors.blue, value: 6, action: normalAction),
      UnoCard(symbol: "7", color: Colors.blue, value: 7, action: normalAction),
      UnoCard(symbol: "8", color: Colors.blue, value: 8, action: normalAction),
      UnoCard(symbol: "9", color: Colors.blue, value: 9, action: normalAction),
      UnoCard(
          symbol: "0", color: Colors.yellow, value: 0, action: normalAction),
      UnoCard(
          symbol: "1", color: Colors.yellow, value: 1, action: normalAction),
      UnoCard(
          symbol: "2", color: Colors.yellow, value: 2, action: normalAction),
      UnoCard(
          symbol: "3", color: Colors.yellow, value: 3, action: normalAction),
      UnoCard(
          symbol: "4", color: Colors.yellow, value: 4, action: normalAction),
      UnoCard(
          symbol: "5", color: Colors.yellow, value: 5, action: normalAction),
      UnoCard(
          symbol: "6", color: Colors.yellow, value: 6, action: normalAction),
      UnoCard(
          symbol: "7", color: Colors.yellow, value: 7, action: normalAction),
      UnoCard(
          symbol: "8", color: Colors.yellow, value: 8, action: normalAction),
      UnoCard(
          symbol: "9", color: Colors.yellow, value: 9, action: normalAction),
      UnoCard(symbol: "0", color: Colors.green, value: 0, action: normalAction),
      UnoCard(symbol: "1", color: Colors.green, value: 1, action: normalAction),
      UnoCard(symbol: "2", color: Colors.green, value: 2, action: normalAction),
      UnoCard(symbol: "3", color: Colors.green, value: 3, action: normalAction),
      UnoCard(symbol: "4", color: Colors.green, value: 4, action: normalAction),
      UnoCard(symbol: "5", color: Colors.green, value: 5, action: normalAction),
      UnoCard(symbol: "6", color: Colors.green, value: 6, action: normalAction),
      UnoCard(symbol: "7", color: Colors.green, value: 7, action: normalAction),
      UnoCard(symbol: "8", color: Colors.green, value: 8, action: normalAction),
      UnoCard(symbol: "9", color: Colors.green, value: 9, action: normalAction),
      UnoCard(symbol: "+2", color: Colors.yellow, value: 20, action: drawTwo),
      UnoCard(symbol: "+2", color: Colors.red, value: 20, action: drawTwo),
      UnoCard(symbol: "+2", color: Colors.blue, value: 20, action: drawTwo),
      UnoCard(symbol: "+2", color: Colors.green, value: 20, action: drawTwo),
      UnoCard(symbol: "+4", color: Colors.yellow, value: 50, action: drawFour),
      UnoCard(symbol: "+4", color: Colors.red, value: 50, action: drawFour),
      UnoCard(symbol: "+4", color: Colors.blue, value: 50, action: drawFour),
      UnoCard(symbol: "+4", color: Colors.green, value: 50, action: drawFour),
    ];

    this.shuffle();
  }

  Widget toWidget() {
    if (cards.isNotEmpty) {
      return cards.last.toWidget();
    } else {
      return Container();
    }
  }
}
