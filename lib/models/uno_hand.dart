import 'package:uno/models/uno_card.dart';
import 'package:flutter/material.dart';
import 'package:uno/models/uno_game.dart';
import 'package:uno/widgets/uno_hand_widget.dart';

enum HandOrientation {
  vertical,
  horizontal,
}

class UnoHand {
  List<UnoCard> cards = [];
  bool isHidden;
  HandOrientation orientation;
  UnoGame game;
  String name;

  UnoHand(
      {this.cards,
      this.game,
      this.isHidden = false,
      this.name = "Computer",
      this.orientation = HandOrientation.horizontal}) {
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

  CardColor getMostColor() {
    var _colors = Map();
    cards.forEach((c) {
      _colors[c.color] =
          !_colors.containsKey(c.color) ? 1 : (_colors[c.color] + 1);
    });
    var _actualColors = _colors.keys.toList();
    var _suitableColors =
        _actualColors.where((c) => c != CardColor.colorless).toList();
    if (_suitableColors.length > 0) {
      _suitableColors.shuffle();
      return _suitableColors.first;
    } else {
      var _allColors = CardColor.values;
      _allColors.shuffle();
      return _allColors.first;
    }
  }

  UnoCard playCardOrDraw(UnoCard card) {
    List<UnoCard> suitable = suitableCards(card);
    if (suitable.length > 0) {
      suitable.shuffle();
      return drawCard(suitable.first);
    }
    return null;
  }

  bool isHorizontal() {
    return orientation == HandOrientation.horizontal;
  }

  bool isVertical() {
    return !isHorizontal();
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
