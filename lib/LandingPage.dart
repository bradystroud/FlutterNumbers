import 'package:flutter/material.dart';

import './GamePage.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Number Puzzle Game",
          style: TextStyle(
            fontFamily: 'sfProReg',
          ),
        ),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GamePage(),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  color: Colors.blue),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 25.0, right: 25.0, top: 8.0, bottom: 8.0),
                child: Text(
                  "PLAY",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
