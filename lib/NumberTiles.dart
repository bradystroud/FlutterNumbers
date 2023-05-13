import 'package:flutter/material.dart';
import 'dart:math';

class NumberTile extends StatefulWidget {
  final Function(List<int>) callback;
  final List numbers;
  final int value;

  NumberTile(this.callback, this.numbers, this.value);

  @override
  _NumberTileState createState() => new _NumberTileState();
}

class _NumberTileState extends State<NumberTile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.numbers[widget.value] != 0) {
      return GestureDetector(
        key: ValueKey<int>(widget.numbers[widget.value]),
        onPanUpdate: (details) {
          if (details.delta.dx > 0) {
            if (widget.numbers[widget.value + 1] == 0) {
              // animate(Offset(0, 1));
              widget.numbers[widget.value + 1] = widget.numbers[widget.value];
              widget.numbers[widget.value] = 0;
              widget.callback(widget.numbers);
              // animate(Offset(0, 1));
              // _controller.forward();

              setState(() {});
            }
          } else if (details.delta.dx < 0) {
            if (widget.numbers[widget.value - 1] == 0) {
              // animate(Offset(0, -1.0));
              widget.numbers[widget.value - 1] = widget.numbers[widget.value];
              widget.numbers[widget.value] = 0;
              widget.callback(widget.numbers);
              // animate(Offset(0, -1.0));
              // _controller.forward();
              setState(() {});
            } //if != 3 or 6
          } else if (details.delta.dy < 0) {
            if (widget.numbers[widget.value - 3] == 0) {
              // animate(Offset(1.0, 0));
              widget.numbers[widget.value - 3] = widget.numbers[widget.value];
              widget.numbers[widget.value] = 0;
              widget.callback(widget.numbers);
              // animate(Offset(1.0, 0));
              // _controller.forward();
              setState(() {});
            }
          } else if (details.delta.dy > 0) {
            print("down");
            if (widget.numbers[widget.value + 3] == 0) {
              widget.numbers[widget.value + 3] = widget.numbers[widget.value];
              widget.numbers[widget.value] = 0;
              widget.callback(widget.numbers);
              // animate(Offset(-1.0, 0));
              // _controller.forward();
              setState(() {});
            }
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 100.0,
            height: 100.0,
            child: Container(
              child: Center(
                child: Text(
                  widget.numbers[widget.value].toString(),
                  style: TextStyle(color: Colors.white, fontSize: 50),
                ),
              ),
              decoration: new BoxDecoration(
                color: Colors.blueGrey,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
            ),
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 100.0,
          height: 100.0,
          child: Container(
            child: Container(),
            decoration: new BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
          decoration: new BoxDecoration(
            border: Border.all(width: 5.0, color: Colors.white),
          ),
        ),
      );
    }
  }
}

List<int> initTileList() {
  var rng = Random();
  List<int> puzzle = List<int>.generate(9, (i) => i); // [0, 1, 2, 3, 4, 5, 6, 7, 8]
  int inversions;

  do {
    puzzle.shuffle(rng);
    inversions = 0;

    for (int i = 0; i < 9; i++) {
      for (int j = i + 1; j < 9; j++) {
        if (puzzle[i] != 0 && puzzle[j] != 0 && puzzle[i] > puzzle[j]) {
          inversions++;
        }
      }
    }
  } while (inversions % 2 != 0); // Ensure the puzzle is solvable

  return puzzle;
}