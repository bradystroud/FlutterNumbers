import 'package:flutter/material.dart';
import 'package:number_puzzle_game/LandingPage.dart';

void main() => runApp(new NumberPuzzleApp());

class NumberPuzzleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'sfProReg',
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LandingPage(),
    );
  }
}

