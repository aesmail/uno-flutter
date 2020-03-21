import 'dart:math';
import 'package:flutter/material.dart';
import 'package:uno/models/uno_card.dart';
import 'package:uno/models/uno_deck.dart';
import 'package:uno/models/uno_hand.dart';
import 'package:uno/models/uno_player.dart';

enum TurnDirection { clockwise, counterclockwise }

class UnoGame {
  int numberOfPlayers;
  List<UnoPlayer> players;
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
    players = List.generate(numberOfPlayers, (index) {
      bool hidden = index != 0;
      String name = hidden ? "AI$index" : "Human";
      bool isHorizontal = index == 0 || index == 2;
      UnoHand hand =
          deck.dealHand(isHidden: hidden, isHorizontal: isHorizontal);
      hand.game = this;
      return UnoPlayer(hand: hand, name: name);
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

  UnoPlayer currentPlayer() => players[currentTurn];

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
    return (currentPlayer() == card.hand.player) && lastCard.canAccept(card);
  }

  bool playCard(UnoCard card) {
    print("${card.hand.player.name}: ${card.symbol}:${card.color}");
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
          var _color = currentPlayer().hand.getMostColor();
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
          var _color = currentPlayer().hand.getMostColor();
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
    print("Cards in deck: ${deck.cards.length}");
    _card.game = this;
    currentPlayer().hand.addCard(_card);
  }

  void drawCardFromDeck() {
    print("${currentPlayer().name} is drawing a card.");
    drawCardAction();
    setNextPlayer();
  }

  bool isGameOver() {
    winner = players.indexWhere((player) => player.hand.cards.isEmpty);
    return winner >= 0;
  }

  void playTurn(var state) {
    print("${currentPlayer().name}'s turn...");
    if (!isGameOver()) {
      if (!this.isHumanTurn()) {
        Random random = Random();
        int seconds = random.nextInt(3) + 2;
        Future.delayed(Duration(seconds: seconds), () {
          UnoCard _card = currentPlayer().hand.playCardOrDraw(currentCard());
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
    return currentPlayer() == humanPlayer();
  }

  UnoPlayer humanPlayer() {
    return this.players[0];
  }
}
