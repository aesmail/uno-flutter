import 'package:uno/models/uno_card.dart';
import 'package:flutter/material.dart';
import 'package:uno/widgets/uno_hand_widget.dart';

enum Orientation {
  vertical,
  horizontal,
}

class UnoHand {
  List<UnoCard> cards = [];
  bool isHidden;
  Orientation orientation;

  UnoHand(
      {this.cards,
      this.isHidden = false,
      this.orientation = Orientation.horizontal}) {
    this.cards = this.cards.map((card) {
      card.hand = this;
      return card;
    }).toList();
  }

  UnoCard drawCard(UnoCard card) {
    if (cards.contains(card)) {
      cards.remove(card);
      return card;
    }
    return null;
  }

  void addCard(UnoCard card) {
    card.hand = this;
    card.isHidden = this.isHidden;
    cards.add(card);
  }

  List<UnoCard> suitableCards(UnoCard card) {
    return cards.where((c) => c.isPlayable(card)).toList();
  }

  UnoCard playCardOrDraw(UnoCard card) {
    List<UnoCard> suitable = suitableCards(card);
    if (suitable.length > 0) {
      suitable.shuffle();
      return drawCard(suitable.first);
    }
    return null;
  }

  void copyHand(UnoHand hand) {
    emptyHand();
    cards = hand.cards;
  }

  void emptyHand() => cards.clear();

  Widget toWidget() {
    return UnoHandWidget(hand: this);
  }
}
