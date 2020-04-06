import 'package:flutter/material.dart';
import 'package:uno/models/uno_card.dart';
import 'package:uno/models/uno_game.dart';
import 'package:uno/models/uno_hand.dart';

class UnoDeck {
  List<UnoCard> cards = [];
  UnoGame game;

  UnoCard drawCard({bool hide = false}) {
    UnoCard _card = cards.removeLast();
    _card.isHidden = hide;
    return _card;
  }

  void setGame(UnoGame theGame) {
    this.game = theGame;
    cards = cards.map((c) {
      c.game = this.game;
      return c;
    }).toList();
  }

  void shuffle() => cards.shuffle();

  UnoHand dealHand({
    int cardCount = 7,
    bool isHidden = false,
    bool isHorizontal = true,
  }) {
    if (cards.length > cardCount) {
      List<UnoCard> _hand = this.cards.sublist(0, cardCount);
      cards.removeRange(0, cardCount);
      _hand.forEach((c) {
        c.game = this.game;
      });
      var orientation =
          isHorizontal ? HandOrientation.horizontal : HandOrientation.vertical;
      return UnoHand(
        cards: _hand,
        isHidden: isHidden,
        orientation: orientation,
        game: game,
      );
    } else {
      throw Exception("Not enough cards in the deck");
    }
  }

  UnoDeck() {
    prepareDeck();
  }

  void prepareDeck() {
    this.cards = createCardSet(CardColor.red) +
        createCardSet(CardColor.blue) +
        createCardSet(CardColor.green) +
        createCardSet(CardColor.yellow);

    this.shuffle();
  }

  List<UnoCard> createCardSet(CardColor setColor) {
    return [
      UnoCard(
        symbol: CardSymbol.zero,
        color: setColor,
        action: CardAction.none,
        value: 0,
      ),
      UnoCard(
        symbol: CardSymbol.one,
        color: setColor,
        action: CardAction.none,
        value: 1,
      ),
      UnoCard(
        symbol: CardSymbol.two,
        color: setColor,
        action: CardAction.none,
        value: 2,
      ),
      UnoCard(
        symbol: CardSymbol.three,
        color: setColor,
        action: CardAction.none,
        value: 3,
      ),
      UnoCard(
        symbol: CardSymbol.four,
        color: setColor,
        action: CardAction.none,
        value: 4,
      ),
      UnoCard(
        symbol: CardSymbol.five,
        color: setColor,
        action: CardAction.none,
        value: 5,
      ),
      UnoCard(
        symbol: CardSymbol.six,
        color: setColor,
        action: CardAction.none,
        value: 6,
      ),
      UnoCard(
        symbol: CardSymbol.seven,
        color: setColor,
        action: CardAction.none,
        value: 7,
      ),
      UnoCard(
        symbol: CardSymbol.eight,
        color: setColor,
        action: CardAction.none,
        value: 8,
      ),
      UnoCard(
        symbol: CardSymbol.nine,
        color: setColor,
        action: CardAction.none,
        value: 9,
      ),
      UnoCard(
        symbol: CardSymbol.drawTwo,
        color: setColor,
        action: CardAction.drawTwo,
        value: 20,
      ),
      UnoCard(
        symbol: CardSymbol.skipTurn,
        color: setColor,
        action: CardAction.skipTurn,
        value: 20,
      ),
      UnoCard(
        symbol: CardSymbol.switchPlay,
        color: setColor,
        action: CardAction.switchPlay,
        value: 20,
      ),
      UnoCard(
        symbol: CardSymbol.one,
        color: setColor,
        action: CardAction.none,
        value: 1,
      ),
      UnoCard(
        symbol: CardSymbol.two,
        color: setColor,
        action: CardAction.none,
        value: 2,
      ),
      UnoCard(
        symbol: CardSymbol.three,
        color: setColor,
        action: CardAction.none,
        value: 3,
      ),
      UnoCard(
        symbol: CardSymbol.four,
        color: setColor,
        action: CardAction.none,
        value: 4,
      ),
      UnoCard(
        symbol: CardSymbol.five,
        color: setColor,
        action: CardAction.none,
        value: 5,
      ),
      UnoCard(
        symbol: CardSymbol.six,
        color: setColor,
        action: CardAction.none,
        value: 6,
      ),
      UnoCard(
        symbol: CardSymbol.seven,
        color: setColor,
        action: CardAction.none,
        value: 7,
      ),
      UnoCard(
        symbol: CardSymbol.eight,
        color: setColor,
        action: CardAction.none,
        value: 8,
      ),
      UnoCard(
        symbol: CardSymbol.nine,
        color: setColor,
        action: CardAction.none,
        value: 9,
      ),
      UnoCard(
        symbol: CardSymbol.drawTwo,
        color: setColor,
        action: CardAction.drawTwo,
        value: 20,
      ),
      UnoCard(
        symbol: CardSymbol.skipTurn,
        color: setColor,
        action: CardAction.skipTurn,
        value: 20,
      ),
      UnoCard(
        symbol: CardSymbol.switchPlay,
        color: setColor,
        action: CardAction.switchPlay,
        value: 20,
      ),
      UnoCard(
        symbol: CardSymbol.changeColor,
        color: CardColor.colorless,
        action: CardAction.changeColor,
        value: 50,
      ),
      UnoCard(
        symbol: CardSymbol.drawFour,
        color: CardColor.colorless,
        action: CardAction.drawFour,
        value: 50,
      ),
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
