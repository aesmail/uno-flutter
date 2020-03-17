import 'package:flutter/material.dart';
import 'package:uno/models/uno_hand.dart';
import 'package:uno/widgets/uno_card_widget.dart';

enum CardSymbol {
  zero,
  one,
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  nine,
  drawTwo,
  drawFour,
  skipTurn,
  changeColor,
  switchPlay,
}

enum CardColor {
  yellow,
  red,
  blue,
  green,
  colorless,
}

enum CardAction {
  none,
  drawTwo,
  drawFour,
  skipTurn,
  switchPlay,
  changeColor,
}

class UnoCard {
  final CardSymbol symbol;
  final CardColor color;
  final CardAction action;
  UnoHand hand;
  bool isHidden;

  UnoCard({this.symbol, this.color, this.action, this.isHidden = true});

  void flipCard() {
    this.isHidden = !this.isHidden;
  }

  bool isPlayable(UnoCard card) {
    return (this.symbol == CardSymbol.changeColor) ||
        (this.symbol == CardSymbol.drawFour) ||
        (card.color == CardColor.colorless) ||
        (this.symbol == card.symbol) ||
        (this.color == card.color);
  }

  String imageName() {
    String colorName = this.color.toString().split('.').last.toLowerCase();
    String symbolName = this.symbol.toString().split('.').last.toLowerCase();
    return "lib/static/images/${colorName}_$symbolName.png";
  }

  Widget toWidget() {
    return UnoCardWidget(card: this);
  }
}
