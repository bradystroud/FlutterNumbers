import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  int _start = 0;
  List<int> listOfNumbers = initTileList();
  int moveCount;
  String formattedStart = '0';

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          _start++;
          formattedStart = printDuration(aSecond * _start);
        },
      ),
    );
  }

  callback(numbers) async {
    HapticFeedback.selectionClick();
    if (numbers.toString() == '[1, 2, 3, 4, 5, 6, 7, 8, 0]') {
      int count = moveCount;
      _start = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WinPage(count, _start.toString())),
      );
      moveCount = -1;
      _start = 0;
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

  void initState() {
    startTimer();
    super.initState();
    moveCount = 0;
    _start = 0;
  }

  int startPosition = 0;
  int endPosition = 0;
  bool dragComplete = true; //If previous drag has been complete

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Solve the puzzle")),
      body: Center(
        child: GestureDetector(
          //VERTICAL DRAG DETECTION
          onVerticalDragEnd: (details) {
            dragComplete = true; //When the drag ends, it listens for new drag
          },
          onVerticalDragUpdate: (details) {
            if (dragComplete) {
              //If the previous drag has complete
              dragComplete = false; //still dragging
              int nullPosition; //the empty tile position
              for (int i = 0; i < 9; i++) {
                //for each tile, check if it's the emptpy position, then set nullPosition to the empty index
                if (listOfNumbers[i] == 0) {
                  nullPosition = i;
                }
              }
              if (details.delta.dy < 0) {
                //If an up swipe

                if (nullPosition < 6) {
                  // if (nullPosition < 3) { //These sections i enable the feature where one swipe can move to tiles, this breaks the app as it is impossible to only swipe a single tile. To solve this, it may be possible to read the gesture from the tile and the grid only action on the tile
                  //   listOfNumbers[nullPosition] =
                  //       listOfNumbers[nullPosition + 3];
                  //   listOfNumbers[nullPosition + 3] =
                  //       listOfNumbers[nullPosition + 6];
                  //   listOfNumbers[nullPosition + 6] = 0;
                  //   callback(listOfNumbers.toString());
                  // } else {
                    listOfNumbers[nullPosition] =
                        listOfNumbers[nullPosition + 3];
                    listOfNumbers[nullPosition + 3] = 0;
                    callback(listOfNumbers.toString());
                  // }
                }
              }
              if (details.delta.dy > 0) {
                if (nullPosition > 2) {
                  // if (nullPosition > 5) {
                  //   //if its in the bottom row
                  //   listOfNumbers[nullPosition] =
                  //       listOfNumbers[nullPosition - 3];
                  //   listOfNumbers[nullPosition - 3] =
                  //       listOfNumbers[nullPosition - 6];
                  //   listOfNumbers[nullPosition - 6] = 0;
                  //   callback(listOfNumbers.toString());
                  // } else {
                    listOfNumbers[nullPosition] =
                        listOfNumbers[nullPosition - 3];
                    listOfNumbers[nullPosition - 3] = 0;
                    callback(listOfNumbers.toString());
                  // }
                }
              }
            }
          },

          //HORIZONTAL DRAG DETECTION
          onHorizontalDragEnd: (details) {
            dragComplete = true;
          },
          onHorizontalDragUpdate: (details) {
            // print(startPosition.toString() + "START");

            if (dragComplete) {
              dragComplete = false;
              int nullPosition;
              for (int i = 0; i < 9; i++) {
                if (listOfNumbers[i] == 0) {
                  nullPosition = i;
                }
              }
              if (details.delta.dx > 0) {
                if (nullPosition != 0 &&
                    nullPosition != 3 &&
                    nullPosition != 6) {
                  // if (nullPosition == 2 ||
                  //     nullPosition == 5 ||
                  //     nullPosition == 8) {
                  //   listOfNumbers[nullPosition] =
                  //       listOfNumbers[nullPosition - 1];
                  //   listOfNumbers[nullPosition - 1] =
                  //       listOfNumbers[nullPosition - 2];
                  //   listOfNumbers[nullPosition - 2] = 0;
                  //   callback(listOfNumbers.toString());
                  // } else {
                    listOfNumbers[nullPosition] =
                        listOfNumbers[nullPosition - 1];
                    listOfNumbers[nullPosition - 1] = 0;
                    callback(listOfNumbers.toString());
                  // }
                }
              }
              if (details.delta.dx < 0) {
                if (nullPosition != 2 &&
                    nullPosition != 5 &&
                    nullPosition != 8) {
                  // if (nullPosition == 0 ||
                  //     nullPosition == 3 ||
                  //     nullPosition == 6) {
                  //   listOfNumbers[nullPosition] =
                  //       listOfNumbers[nullPosition + 1];
                  //   listOfNumbers[nullPosition + 1] =
                  //       listOfNumbers[nullPosition + 2];
                  //   listOfNumbers[nullPosition + 2] = 0;
                  //   callback(listOfNumbers.toString());
                  // } else {
                    listOfNumbers[nullPosition] =
                        listOfNumbers[nullPosition + 1];
                    listOfNumbers[nullPosition + 1] = 0;
                    callback(listOfNumbers.toString());
                  // }
                }
              }
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text('Moves: ' + (moveCount).toString()),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(formattedStart),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: tileListGenerator(listOfNumbers, 0, callback),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: tileListGenerator(listOfNumbers, 3, callback),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: tileListGenerator(listOfNumbers, 6, callback),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<Widget> tileListGenerator(listOfNumbers, rowStartPoint, callback) {
  List<Widget> tileList = [];
  for (int i = rowStartPoint; i < rowStartPoint + 3; i++) {
    tileList.add(NumberTile("Hello World", callback, listOfNumbers, i));
  }
  return tileList;
}
