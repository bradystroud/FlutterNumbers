import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:duration/duration.dart';

import './WriteHighScore.dart';

class WinPage extends StatefulWidget {
  final int moveCount;
  final String time;

  WinPage(this.moveCount, this.time);

  @override
  _WinPageState createState() => _WinPageState();
}

class _WinPageState extends State<WinPage> {
  late ConfettiController _controllerCenter;
  late ScoreModel highScores;

  void initState() {
    writeHighScore(widget.moveCount, int.parse(widget.time)).then((value) {
      highScores = value;
      setState(() {});
    });
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 10));
    _controllerCenter.play();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("You Won"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).popUntil((route) {
                  return route.settings.name == "/";
                });
              }),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ConfettiWidget(
                minBlastForce: 1,
                numberOfParticles: 20,
                confettiController: _controllerCenter,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
              ),
              Padding(padding: EdgeInsets.only(top: 50)),
              Text(
                'You won!',
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
              ),
              Padding(padding: EdgeInsets.all(50)),
              Text(
                'Scores',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Moves: ' + widget.moveCount.toString(),
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Time: ' + printDuration(aSecond * int.parse(widget.time)),
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.all(50)),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Text(
                  'High Score',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Moves: ${highScores.moveCount.toString()}',
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Time: ${highScores.time.toString()}',
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
