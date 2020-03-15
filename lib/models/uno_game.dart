import 'package:uno/models/uno_card.dart';
import 'package:uno/models/uno_deck.dart';
import 'package:uno/models/uno_hand.dart';

class UnoGame {
  int numberOfPlayers;
  List<UnoHand> hands;
  UnoDeck deck;
  int currentTurn;
  List<UnoCard> thrown;

  UnoGame({this.numberOfPlayers = 2});

  void prepareGame() {
    deck = UnoDeck();
    hands = List.generate(numberOfPlayers, (index) {
      return deck.dealHand(isHidden: index == 0);
    });
    thrown = [deck.drawCard()];
    currentTurn = 0;
  }

  UnoHand currentHand() => hands[currentTurn];

  bool canPlayCard(UnoCard card) {
    UnoCard lastCard = thrown.last;
    print(card.symbol);
    print(lastCard.symbol);
    print(card.color);
    print(lastCard.color);
    if (hands[currentTurn] == card.hand) {
      return (lastCard.color == card.color) || (lastCard.symbol == card.symbol);
    }
    return false;
  }

  bool playCard(UnoCard card) {
    if (canPlayCard(card)) {
      card.hand.drawCard(card);
      card.isHidden = false;
      thrown.add(card);
      setNextPlayer();
      return true;
    }
    return false;
  }

  void setNextPlayer() {
    currentTurn = ((currentTurn + 1) % currentTurn).round();
  }
}
