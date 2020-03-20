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
      String name = hidden ? "AI $index" : "Human";
      bool isHorizontal = index == 0 || index == 2;
      UnoHand hand = deck.dealHand(
          name: name, isHidden: hidden, isHorizontal: isHorizontal);
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
    print("Initial card: ${firstCard.symbol}:${firstCard.color}");
    currentTurn = 0;
  }

  UnoHand currentHand() => hands[currentTurn];

  Color getPlayingColor() {
    switch (currentColor) {
      case CardColor.blue:
        return Colors.blue[600];
      case CardColor.red:
        return Colors.red[600];
      case CardColor.green:
        return Colors.green[600];
      case CardColor.yellow:
        return Colors.yellow[600];
      case CardColor.colorless:
        return Colors.black;
    }
    return Colors.white;
  }

  bool canPlayCard(UnoCard card) {
    UnoCard lastCard = currentCard();
    return (currentHand() == card.hand) && lastCard.canAccept(card);
  }

  bool playCard(UnoCard card) {
    print("${card.hand.name}: ${card.symbol}:${card.color}");
    if (canPlayCard(card)) {
      card.hand.drawCard(card);
      card.isHidden = false;
      card.hand = null;
      card.game = this;
      thrown.add(card);
      setColor(card.color);
      return doCardAction(card);
    }
    return false;
  }

  void setColor(CardColor color) {
    currentColor = color;
  }

  bool needsColorDecision() {
    return currentColor == CardColor.colorless;
  }

  bool doCardAction(UnoCard card) {
    switch (card.action) {
      case CardAction.skipTurn:
        setNextPlayer(skip: 2);
        return true;
      case CardAction.switchPlay:
        switchPlay();
        setNextPlayer();
        return true;
      case CardAction.drawTwo:
        setNextPlayer();
        drawCardAction();
        drawCardAction();
        setNextPlayer();
        return true;
      case CardAction.drawFour:
        if (this.isHumanTurn()) {
          print("Human must choose color.");
          setNextPlayer();
          drawCardAction();
          drawCardAction();
          drawCardAction();
          drawCardAction();
          setNextPlayer();
          return false;
        } else {
          var _color = currentHand().getMostColor();
          print("Choosing color: $_color");
          this.setColor(_color);
          setNextPlayer();
          drawCardAction();
          drawCardAction();
          drawCardAction();
          drawCardAction();
          setNextPlayer();
        }
        print("AI chose color.");
        return true;
      case CardAction.changeColor:
        if (this.isHumanTurn()) {
          print("Human must choose color.");
          setNextPlayer();
          return false;
        } else {
          var _color = currentHand().getMostColor();
          print("Choosing color: $_color");
          setNextPlayer();
          this.setColor(_color);
        }
        print("AI chose color.");
        return true;
      case CardAction.none:
        setNextPlayer();
        return true;
    }
    return true;
  }

  UnoCard currentCard() {
    return thrown.last;
  }

  void setNextPlayer({int skip = 1}) {
    if (turnDirection == TurnDirection.clockwise) {
      currentTurn = ((currentTurn + skip) % numberOfPlayers).round();
    } else {
      currentTurn = ((currentTurn - skip) % numberOfPlayers).round();
    }
    print("Current Turn: $currentTurn");
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
    print("${currentHand().name} is drawing a card.");
    drawCardAction();
    setNextPlayer();
  }

  bool isGameOver() {
    winner = hands.indexWhere((hand) => hand.cards.isEmpty);
    return winner >= 0;
  }

  void playTurn(var state) {
    print("${currentHand().name}'s turn...");
    if (!isGameOver()) {
      if (!this.isHumanTurn()) {
        Random random = Random();
        int seconds = random.nextInt(3) + 2;
        Future.delayed(Duration(seconds: seconds), () {
          UnoCard _card = currentHand().playCardOrDraw(currentCard());
          if (_card == null) {
            drawCardFromDeck();
            playTurn(state);
          } else {
            if (playCard(_card)) playTurn(state);
          }
          state.setState(() {});
        });
      }
    }
  }

  bool isHumanTurn() {
    return currentHand() == humanHand();
  }

  UnoHand humanHand() {
    return this.hands[0];
  }
}
