import 'package:uno/models/uno_card.dart';
import 'package:uno/models/uno_deck.dart';
import 'package:uno/models/uno_hand.dart';

class UnoGame {
  int numberOfPlayers;
  List<UnoHand> hands;
  UnoDeck deck;
  int currentTurn;
  List<UnoCard> thrown;
  int winner = -1;

  UnoGame({this.numberOfPlayers = 2});

  void prepareGame() {
    deck = UnoDeck();
    hands = List.generate(numberOfPlayers, (index) {
      return deck.dealHand(isHidden: false);
    });
    thrown = [deck.drawCard()];
    currentTurn = 0;
  }

  UnoHand currentHand() => hands[currentTurn];

  bool canPlayCard(UnoCard card) {
    UnoCard lastCard = thrown.last;
    return (hands[currentTurn] == card.hand) && lastCard.isPlayable(card);
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
    currentTurn = ((currentTurn + 1) % numberOfPlayers).round();
  }

  void drawCardFromDeck() {
    UnoCard _card = deck.drawCard(hide: false);
    currentHand().addCard(_card);
    setNextPlayer();
  }

  bool isGameOver() {
    winner = hands.indexWhere((hand) => hand.cards.isEmpty);
    return winner >= 0;
  }
}
