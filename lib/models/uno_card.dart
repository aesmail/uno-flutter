import 'package:flutter/material.dart';
import 'package:uno/models/uno_game.dart';
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
  UnoGame game;
  bool isHidden;

  UnoCard({this.symbol, this.color, this.action, this.isHidden = true});

  void flipCard() {
    this.isHidden = !this.isHidden;
  }

  bool isPlayable(UnoCard card) {
    if (this.symbol == CardSymbol.changeColor) return true;
    if (this.symbol == CardSymbol.drawFour) {
      return (this.color == this.game.currentColor) ||
          (this.color == CardColor.colorless);
    }
    return (this.color == card.color || this.symbol == card.symbol);
  }

  bool canAccept(UnoCard card) {
    if (card.symbol == CardSymbol.changeColor) return true;
    if (card.symbol == CardSymbol.drawFour) return true;
    return (card.color == this.color) || (card.symbol == this.symbol);
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
