import 'package:flutter/material.dart';
import 'package:uno/models/uno_action.dart';
import 'package:uno/models/uno_hand.dart';
import 'package:uno/widgets/uno_card_widget.dart';

class UnoCard {
  final String symbol;
  final int value;
  final Color color;
  UnoHand hand;
  bool isHidden;
  UnoAction action;

  UnoCard(
      {this.symbol, this.color, this.value, this.action, this.isHidden = true});

  void flipCard() {
    this.isHidden = !this.isHidden;
  }

  bool isPlayable(UnoCard card) {
    return (this.symbol == card.symbol) || (this.color == card.color);
  }

  Widget toWidget() {
    return UnoCardWidget(card: this);
  }
}
