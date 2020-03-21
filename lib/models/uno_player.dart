import 'package:uno/models/uno_hand.dart';

class UnoPlayer {
  UnoHand hand;
  String name;

  UnoPlayer({this.hand, this.name}) {
    this.hand.player = this;
  }
}
