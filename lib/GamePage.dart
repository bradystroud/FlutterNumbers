import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'package:duration/duration.dart';


import './winPage.dart';
import './NumberTiles.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  Timer _timer;
  int _elapsedTime = 0;
  List<int> listOfNumbers = initTileList();
  int moveCount;
  String formattedElapsedTime = '0';

  bool dragComplete = true;

  callback(List<int> numbers) async {
    HapticFeedback.selectionClick();
    if (listEquals(numbers, [1, 2, 3, 4, 5, 6, 7, 8, 0])) {
      int count = moveCount;
      _elapsedTime = await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => WinPage(count, _elapsedTime.toString())),
      );
      moveCount = -1;
      _elapsedTime = 0;
    }
    setState(() {
      moveCount++;
    });
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          _elapsedTime++;
          formattedElapsedTime = printDuration(aSecond * _elapsedTime);
        },
      ),
    );
  }
  
  void onTileMoved(List<int> numbers) async {
    HapticFeedback.selectionClick();
    if (listEquals(numbers, [1, 2, 3, 4, 5, 6, 7, 8, 0])) {
      int count = moveCount;
      _elapsedTime = await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => WinPage(count, _elapsedTime.toString())),
      );
      moveCount = -1;
      _elapsedTime = 0;
    }
    setState(() {
      moveCount++;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    startTimer();
    super.initState();
    moveCount = 0;
    _elapsedTime = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Solve the puzzle")),
      body: Center(
        child: GestureDetector(
          onVerticalDragEnd: (details) => _onVerticalDragEnd(details),
          onVerticalDragUpdate: (details) => _onVerticalDragUpdate(details),
          onHorizontalDragEnd: (details) => _onHorizontalDragEnd(details),
          onHorizontalDragUpdate: (details) => _onHorizontalDragUpdate(details),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text('Moves: ' + moveCount.toString()),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(formattedElapsedTime),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _generateTileList(listOfNumbers, 0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _generateTileList(listOfNumbers, 3),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _generateTileList(listOfNumbers, 6),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Additional utility functions and gesture handling functions

  void _onVerticalDragEnd(DragEndDetails details) {
    setState(() {
      dragComplete = true;
    });
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    if (dragComplete) {
      dragComplete = false;
      int nullPosition;
      for (int i = 0; i < 9; i++) {
        if (listOfNumbers[i] == 0) {
          nullPosition = i;
        }
      }
      if (details.delta.dy < 0) {
        if (nullPosition < 6) {
          setState(() {
            listOfNumbers[nullPosition] = listOfNumbers[nullPosition + 3];
            listOfNumbers[nullPosition + 3] = 0;
            callback(listOfNumbers);
          });
        }
      }
      if (details.delta.dy > 0) {
        if (nullPosition > 2) {
          setState(() {
            listOfNumbers[nullPosition] = listOfNumbers[nullPosition - 3];
            listOfNumbers[nullPosition - 3] = 0;
            callback(listOfNumbers);
          });
        }
      }
    }
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    setState(() {
      dragComplete = true;
    });
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    if (dragComplete) {
      dragComplete = false;
      int nullPosition;
      for (int i = 0; i < 9; i++) {
        if (listOfNumbers[i] == 0) {
          nullPosition = i;
        }
      }
      if (details.delta.dx > 0) {
        if (nullPosition != 0 && nullPosition != 3 && nullPosition != 6) {
          setState(() {
            listOfNumbers[nullPosition] = listOfNumbers[nullPosition - 1];
            listOfNumbers[nullPosition - 1] = 0;
            callback(listOfNumbers);
          });
        }
      }
      if (details.delta.dx < 0) {
        if (nullPosition != 2 && nullPosition != 5 && nullPosition != 8) {
          setState(() {
            listOfNumbers[nullPosition] = listOfNumbers[nullPosition + 1];
            listOfNumbers[nullPosition + 1] = 0;
            callback(listOfNumbers);
          });
        }
      }
    }
  }

  List<Widget> _generateTileList(List<int> numbers, int rowStartIndex) {
    List<Widget> tileList = [];
    for (int i = rowStartIndex; i < rowStartIndex + 3; i++) {
      tileList.add(NumberTile("Hello World", onTileMoved, numbers, i));
    }
    return tileList;
  }

  List<Widget> tileListGenerator(listOfNumbers, rowStartPoint, callback) {
    List<Widget> tileList = [];
    for (int i = rowStartPoint; i < rowStartPoint + 3; i++) {
      tileList.add(NumberTile("Hello World", callback, listOfNumbers, i));
    }
    return tileList;
  }
}
