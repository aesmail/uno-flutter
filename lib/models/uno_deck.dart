import 'package:flutter/material.dart';
import 'package:uno/models/uno_card.dart';
import 'package:uno/models/uno_hand.dart';

class UnoDeck {
  List<UnoCard> cards = [];

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
    cards = [
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

    this.shuffle();
  }
}
