import 'package:flutter/material.dart';
import 'package:uno/widgets/uno_card.dart';
import 'package:uno/widgets/uno_deck.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'عونو التجريبي'),
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
  Widget deck;
  List<UnoCard> _currentPlay;

  @override
  initState() {
    super.initState();
    deck = UnoDeck();
    _currentPlay = [];
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
              onPressed: () => print("draw card"),
              child: Text("Deck Goes Here"),
            ),
            Expanded(child: deck),
            DragTarget<UnoCard>(
              onWillAccept: (UnoCard value) {
                return true;
              },
              onAccept: (UnoCard value) {
                _currentPlay.add(value);
              },
              // onLeave: (value) {
              //   print("the value left");
              //   print(value);
              // },
              builder: (context, list1, list2) {
                // print("building the DragTarget");
                return _currentPlay.isNotEmpty
                    ? _currentPlay.last
                    : Container(color: Colors.grey, height: 200, width: 200);
              },
            ),
          ],
        ),
      ),
    );
  }
}
