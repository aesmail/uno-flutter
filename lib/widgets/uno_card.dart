import 'package:flutter/material.dart';

class UnoCard extends StatelessWidget {
  const UnoCard({Key key, @required this.symbol, @required this.color})
      : super(key: key);

  factory UnoCard.fromCard(UnoCard card) {
    return UnoCard(color: card.color, symbol: card.symbol);
  }

  final String symbol;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.black26, width: 0.5),
        color: this.color,
      ),
      height: 150,
      width: 100,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5, left: 7),
                    child: Text(this.symbol,
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
                this.symbol,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 90,
                  fontWeight: FontWeight.bold,
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
}
