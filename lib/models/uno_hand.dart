import 'package:uno/models/uno_card.dart';
import 'package:flutter/material.dart';
import 'package:uno/widgets/uno_hand_widget.dart';

class UnoHand {
  List<UnoCard> cards = [];

  UnoHand({this.cards});

  UnoCard drawCard(UnoCard card) {
    if (cards.contains(card)) {
      cards.remove(card);
      return card;
    }
    return null;
  }

  void addCard(UnoCard card) => cards.add(card);

  void copyHand(UnoHand hand) {
    emptyHand();
    cards = hand.cards;
  }

  void emptyHand() => cards.clear();

  Widget toWidget() {
    return UnoHandWidget(hand: this);
  }
}
