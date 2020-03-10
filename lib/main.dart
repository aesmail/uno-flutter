import 'package:flutter/material.dart';
import 'package:uno/widgets/uno_card_widget.dart';
import 'models/uno_deck.dart';
import 'models/uno_hand.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Uno',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Uno Flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  UnoDeck deck;
  UnoHand hand;
  List<UnoCardWidget> thrown = [];

  @override
  initState() {
    super.initState();
    deck = UnoDeck();
    hand = deck.dealHand(cardCount: 7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            FlatButton(
              onPressed: () {
                this.setState(() {
                  thrown.clear();
                  deck = UnoDeck();
                  hand.copyHand(deck.dealHand());
                });
              },
              child: Text("Reset Hand"),
            ),
            DragTarget<UnoCardWidget>(
              onWillAccept: (UnoCardWidget value) {
                return true;
              },
              onAccept: (UnoCardWidget value) {
                this.setState(() {
                  hand.drawCard(value.card);
                  thrown.add(value);
                });
              },
              builder: (context, list1, list2) {
                return thrown.isNotEmpty
                    ? thrown.last
                    : Container(color: Colors.grey, height: 200, width: 200);
              },
            ),
            Expanded(child: hand.toWidget()),
          ],
        ),
      ),
    );
  }
}
