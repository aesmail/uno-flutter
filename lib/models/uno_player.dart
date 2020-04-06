import 'package:uno/models/uno_hand.dart';

class UnoPlayer {
  UnoHand hand;
  String name;
  int roundScore = 0;
  int gameScore = 0;

  UnoPlayer({this.hand, this.name}) {
    this.hand.player = this;
  }

  int calculateScore() {
    this.roundScore = 0;
    this.hand.cards.forEach((card) {
      this.roundScore += card.value;
    });
    return this.roundScore;
  }

  void addToGameScore() {
    this.gameScore += this.roundScore;
  }
}
