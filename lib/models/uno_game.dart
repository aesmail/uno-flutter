import 'dart:math';
import 'package:flutter/material.dart';
import 'package:uno/models/uno_card.dart';
import 'package:uno/models/uno_deck.dart';
import 'package:uno/models/uno_hand.dart';

enum TurnDirection { clockwise, counterclockwise }

class UnoGame {
  int numberOfPlayers;
  List<UnoHand> hands;
  UnoDeck deck;
  int currentTurn;
  List<UnoCard> thrown;
  int winner;
  TurnDirection turnDirection;
  CardColor currentColor;

  UnoGame({this.numberOfPlayers = 4});

  void prepareGame() {
    deck = UnoDeck();
    deck.setGame(this);
    hands = List.generate(numberOfPlayers, (index) {
      bool hidden = index != 0;
      bool isHorizontal = index == 0 || index == 2;
      UnoHand hand =
          deck.dealHand(isHidden: hidden, isHorizontal: isHorizontal);
      hand.game = this;
      return hand;
    });
    UnoCard firstCard = deck.drawCard();
    firstCard.game = this;
    currentColor = firstCard.color;
    thrown = [firstCard];
    winner = -1;
    turnDirection = TurnDirection.clockwise;
    // Random random = Random();
    currentTurn = 0;
  }

  UnoHand currentHand() => hands[currentTurn];

  Color getPlayingColor() {
    switch (currentColor) {
      case CardColor.blue:
        return Colors.blue[900];
      case CardColor.red:
        return Colors.red[900];
      case CardColor.green:
        return Colors.green[900];
      case CardColor.yellow:
        return Colors.yellow[900];
      case CardColor.colorless:
        return Colors.white;
    }
    return Colors.white;
  }

  bool canPlayCard(UnoCard card) {
    UnoCard lastCard = currentCard();
    return (hands[currentTurn] == card.hand) && lastCard.canAccept(card);
  }

  bool playCard(UnoCard card) {
    if (canPlayCard(card)) {
      card.hand.drawCard(card);
      card.isHidden = false;
      card.hand = null;
      card.game = this;
      thrown.add(card);
      setColor(card.color);
      doCardAction(card);
      setNextPlayer();
      return true;
    }
    return false;
  }

  void setColor(CardColor color) {
    currentColor = color;
  }

  bool needsColorDecision() {
    return currentColor == CardColor.colorless;
  }

  void doCardAction(UnoCard card) {
    switch (card.action) {
      case CardAction.skipTurn:
        setNextPlayer();
        break;
      case CardAction.switchPlay:
        switchPlay();
        break;
      case CardAction.drawTwo:
        setNextPlayer();
        drawCardAction();
        drawCardAction();
        break;
      case CardAction.drawFour:
        setNextPlayer();
        drawCardAction();
        drawCardAction();
        drawCardAction();
        drawCardAction();
        break;
      case CardAction.changeColor:
        break;
      case CardAction.none:
        break;
    }
  }

  UnoCard currentCard() {
    return thrown.last;
  }

  void setNextPlayer() {
    if (turnDirection == TurnDirection.clockwise) {
      currentTurn = ((currentTurn + 1) % numberOfPlayers).round();
    } else {
      currentTurn = ((currentTurn - 1) % numberOfPlayers).round();
    }
  }

  void switchPlay() {
    if (turnDirection == TurnDirection.clockwise) {
      turnDirection = TurnDirection.counterclockwise;
    } else {
      turnDirection = TurnDirection.clockwise;
    }
  }

  void drawCardAction() {
    UnoCard _card = deck.drawCard(hide: false);
    _card.game = this;
    currentHand().addCard(_card);
  }

  void drawCardFromDeck() {
    drawCardAction();
    setNextPlayer();
  }

  bool isGameOver() {
    winner = hands.indexWhere((hand) => hand.cards.isEmpty);
    return winner >= 0;
  }

  void playTurn(var state) {
    print("Playing turn. Hand: $currentTurn");
    if (!isGameOver()) {
      if (currentTurn > 0) {
        Random random = Random();
        int seconds = random.nextInt(3) + 2;
        Future.delayed(Duration(seconds: seconds), () {
          UnoCard _card = currentHand().playCardOrDraw(currentCard());
          if (_card == null) {
            drawCardFromDeck();
          } else {
            playCard(_card);
          }
          state.setState(() {});
          playTurn(state);
        });
      }
    }
  }
}
