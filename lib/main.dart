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
  UnoHand opponent;
  List<UnoCardWidget> thrown = [];

  @override
  initState() {
    super.initState();
    deck = UnoDeck();
    hand = deck.dealHand();
    opponent = deck.dealHand(isHidden: true);
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
            Expanded(child: opponent.toWidget()),
            playTable(context),
            Expanded(child: hand.toWidget()),
          ],
        ),
      ),
    );
  }

  Widget playTable(context) {
    Size screen = MediaQuery.of(context).size;
    return DragTarget<UnoCardWidget>(
      onWillAccept: (UnoCardWidget value) {
        return true;
      },
      onAccept: (UnoCardWidget cardWidget) {
        this.setState(() {
          cardWidget.card.isHidden = false;
          hand.drawCard(cardWidget.card);
          thrown.add(cardWidget);
        });
      },
      builder: (context, list1, list2) {
        return thrown.isNotEmpty
            ? Container(
                color: Colors.green[200],
                height: 200,
                width: screen.width,
                child: Center(child: thrown.last),
              )
            : Container(
                color: Colors.green[200], height: 200, width: screen.width);
      },
    );
  }
}
