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
      UnoHand hand = deck.dealHand(isHidden: index == 0);
      hand.game = this;
      return hand;
    });
    thrown = [deck.drawCard()];
    currentTurn = 1;
  }

  UnoHand currentHand() => hands[currentTurn];

  bool canPlayCard(UnoCard card) {
    UnoCard lastCard = currentCard();
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

  UnoCard currentCard() {
    return thrown.last;
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
