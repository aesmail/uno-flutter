import 'dart:math';
import 'package:flutter/material.dart';
import 'package:uno/models/uno_card.dart';

class UnoCardWidget extends StatelessWidget {
  const UnoCardWidget({Key key, @required this.card}) : super(key: key);

  final UnoCard card;
  final double cardHeight = 100;
  final double cardWidth = 75;

  @override
  Widget build(BuildContext context) {
    if (card.hand != null && card.hand.isVertical()) {
      if (card.isHidden) {
        return Transform.rotate(
          angle: 90 * pi / 180,
          child: backFace(),
        );
      } else {
        return Transform.rotate(
          angle: 90 * pi / 180,
          child: frontFace(),
        );
      }
    } else {
      return card.isHidden ? backFace() : frontFace();
    }
  }

  Widget frontFace() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      height: cardHeight,
      width: cardWidth,
      child: Image.asset(this.card.imageName()),
    );
  }

  Widget backFace() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      height: cardHeight,
      width: cardWidth,
      child: Image.asset("lib/static/images/card_back.png"),
    );
  }
}
