import 'package:flutter/material.dart';
import 'package:uno/widgets/uno_card_widget.dart';
import 'models/uno_card.dart';
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
        primarySwatch: Colors.red,
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
    return DragTarget<UnoCard>(
      onWillAccept: (UnoCard card) {
        return true;
      },
      onAccept: (UnoCard card) {
        print("card: ${card.symbol}");
        card.isHidden = false;
        UnoHand _currentHand = card.hand;
        print("Hand isHidden: ${_currentHand.isHidden}");
        print("isHidden should always be false: ${card.isHidden}");
        _currentHand.drawCard(card);
        UnoCardWidget cardWidget = card.toWidget();
        print("Widget card isHidden: ${cardWidget.card.isHidden}");
        thrown.add(cardWidget);
        print("Cards thrown: ${thrown.length}");
        this.setState(() {});
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
