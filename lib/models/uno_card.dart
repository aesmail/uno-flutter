import 'package:flutter/material.dart';
import 'package:uno/models/uno_hand.dart';
import 'package:uno/widgets/uno_card_widget.dart';

class UnoCard {
  final String symbol;
  final int value;
  final Color color;
  UnoHand hand;
  bool isHidden;

  UnoCard({this.symbol, this.color, this.value, this.isHidden = false});

  void flipCard() {
    this.isHidden = !this.isHidden;
  }

  Widget toWidget() {
    return UnoCardWidget(card: this);
  }
}
