import 'package:flutter/material.dart';
import 'package:uno/widgets/uno_card_widget.dart';

class UnoCard {
  final String symbol;
  final int value;
  final Color color;
  bool isHidden;

  UnoCard({this.symbol, this.color, this.value, this.isHidden = false});

  Widget toWidget() {
    return UnoCardWidget(card: this);
  }
}
