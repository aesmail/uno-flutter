import 'package:uno/models/uno_card.dart';
import 'package:uno/models/uno_deck.dart';
import 'package:uno/models/uno_hand.dart' as unoHand;

class UnoGame {
  int numberOfPlayers;
  List<unoHand.UnoHand> hands;
  UnoDeck deck;
  int currentTurn;
  List<UnoCard> thrown;
  int winner = -1;

  UnoGame({this.numberOfPlayers = 4});

  void prepareGame() {
    deck = UnoDeck();
    hands = List.generate(numberOfPlayers, (index) {
      bool hidden = index != 0;
      bool isHorizontal = index == 0 || index == 2;
      unoHand.UnoHand hand =
          deck.dealHand(isHidden: hidden, isHorizontal: isHorizontal);
      hand.game = this;
      return hand;
    });
    thrown = [deck.drawCard()];
    currentTurn = 0;
  }

  unoHand.UnoHand currentHand() => hands[currentTurn];

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
