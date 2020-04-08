import 'package:flutter/material.dart';
import 'package:uno/widgets/uno_game_widget.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        top: true,
        left: true,
        bottom: true,
        right: true,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Image.asset("lib/static/backgrounds/background.jpeg"),
            ),
            Positioned(
              top: 10,
              left: 20,
              width: 80,
              height: 80,
              child: Container(
                child: Image.asset("lib/static/images/logo.png"),
              ),
            ),
            Positioned(
              top: screen.height / 2 - ((screen.height / 5) / 2),
              left: screen.width / 2 - ((screen.width / 3) / 2),
              child: Container(
                width: screen.width / 3,
                height: screen.height / 5,
                child: FlatButton(
                  child: Image.asset("lib/static/images/new_game.png"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return UnoGameWidget();
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
