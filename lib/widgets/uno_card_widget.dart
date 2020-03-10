import 'package:flutter/material.dart';
import 'package:uno/models/uno_card.dart';

class UnoCardWidget extends StatelessWidget {
  const UnoCardWidget({Key key, @required this.card}) : super(key: key);

  final UnoCard card;
  final double cardHeight = 100;
  final double cardWidth = 75;
  final double cardFontSize = 55;
  final double borderWidth = 4.0;

  @override
  Widget build(BuildContext context) {
    return card.isHidden ? backFace() : frontFace();
  }

  Widget frontFace() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white, width: borderWidth),
        color: this.card.color,
      ),
      height: cardHeight,
      width: cardWidth,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5, left: 7),
                    child: Text(this.card.symbol,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 11.0,
                            fontFamily: 'RobotoMono',
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                  offset: Offset(0.5, 0.5),
                                  blurRadius: 2.0,
                                  color: Colors.grey)
                            ])),
                  ),
                ),
              ],
            ),
            Center(
              child: Text(
                this.card.symbol,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: cardFontSize,
                  // fontWeight: FontWeight.bold,
                  fontFamily: 'RobotoMono',
                  shadows: [
                    Shadow(
                        offset: Offset(0.5, 0.5),
                        blurRadius: 2.0,
                        color: Colors.grey),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget backFace() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white, width: borderWidth),
        color: Colors.black,
      ),
      height: cardHeight,
      width: cardWidth,
      child: Container(),
    );
  }
}
