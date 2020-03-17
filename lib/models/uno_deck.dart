import 'package:flutter/material.dart';
// import 'package:uno/models/uno_action.dart';
import 'package:uno/models/uno_card.dart';
import 'package:uno/models/uno_hand.dart' as unoHand;

class UnoDeck {
  List<UnoCard> cards = [];

  UnoCard drawCard({bool hide = false}) {
    UnoCard _card = cards.removeLast();
    _card.isHidden = hide;
    return _card;
  }

  void shuffle() => cards.shuffle();

  unoHand.UnoHand dealHand(
      {int cardCount = 7, bool isHidden = false, bool isHorizontal = true}) {
    if (cards.length > cardCount) {
      List<UnoCard> _hand = cards.sublist(0, cardCount);
      cards.removeRange(0, cardCount);
      var orientation = isHorizontal
          ? unoHand.Orientation.horizontal
          : unoHand.Orientation.vertical;
      return unoHand.UnoHand(
          cards: _hand, isHidden: isHidden, orientation: orientation);
    }
    return null;
  }

  UnoDeck() {
    cards = createCardSet(CardColor.red) +
        createCardSet(CardColor.blue) +
        createCardSet(CardColor.green) +
        createCardSet(CardColor.yellow);

    this.shuffle();
  }

  List<UnoCard> createCardSet(CardColor setColor) {
    return [
      UnoCard(
          symbol: CardSymbol.zero, color: setColor, action: CardAction.none),
      UnoCard(symbol: CardSymbol.one, color: setColor, action: CardAction.none),
      UnoCard(symbol: CardSymbol.two, color: setColor, action: CardAction.none),
      UnoCard(
          symbol: CardSymbol.three, color: setColor, action: CardAction.none),
      UnoCard(
          symbol: CardSymbol.four, color: setColor, action: CardAction.none),
      UnoCard(
          symbol: CardSymbol.five, color: setColor, action: CardAction.none),
      UnoCard(symbol: CardSymbol.six, color: setColor, action: CardAction.none),
      UnoCard(
          symbol: CardSymbol.seven, color: setColor, action: CardAction.none),
      UnoCard(
          symbol: CardSymbol.eight, color: setColor, action: CardAction.none),
      UnoCard(
          symbol: CardSymbol.nine, color: setColor, action: CardAction.none),
      UnoCard(
          symbol: CardSymbol.drawTwo,
          color: setColor,
          action: CardAction.drawTwo),
      UnoCard(
          symbol: CardSymbol.skipTurn,
          color: setColor,
          action: CardAction.skipTurn),
      UnoCard(
          symbol: CardSymbol.switchPlay,
          color: setColor,
          action: CardAction.switchPlay),
      UnoCard(symbol: CardSymbol.one, color: setColor, action: CardAction.none),
      UnoCard(symbol: CardSymbol.two, color: setColor, action: CardAction.none),
      UnoCard(
          symbol: CardSymbol.three, color: setColor, action: CardAction.none),
      UnoCard(
          symbol: CardSymbol.four, color: setColor, action: CardAction.none),
      UnoCard(
          symbol: CardSymbol.five, color: setColor, action: CardAction.none),
      UnoCard(symbol: CardSymbol.six, color: setColor, action: CardAction.none),
      UnoCard(
          symbol: CardSymbol.seven, color: setColor, action: CardAction.none),
      UnoCard(
          symbol: CardSymbol.eight, color: setColor, action: CardAction.none),
      UnoCard(
          symbol: CardSymbol.nine, color: setColor, action: CardAction.none),
      UnoCard(
          symbol: CardSymbol.drawTwo,
          color: setColor,
          action: CardAction.drawTwo),
      UnoCard(
          symbol: CardSymbol.skipTurn,
          color: setColor,
          action: CardAction.skipTurn),
      UnoCard(
          symbol: CardSymbol.switchPlay,
          color: setColor,
          action: CardAction.switchPlay),
      UnoCard(
          symbol: CardSymbol.changeColor,
          color: CardColor.colorless,
          action: CardAction.changeColor),
      UnoCard(
          symbol: CardSymbol.drawFour,
          color: CardColor.colorless,
          action: CardAction.drawFour),
    ];
  }

  Widget toWidget() {
    if (cards.isNotEmpty) {
      return cards.last.toWidget();
    } else {
      return Container();
    }
  }
}
