// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:number_puzzle_game/GamePage.dart';
import 'package:number_puzzle_game/NumberTiles.dart';

void main() {
  testWidgets('GamePage renders correctly', (WidgetTester tester) async {
    // Build the GamePage widget
    await tester.pumpWidget(MaterialApp(home: GamePage()));

    // Find the AppBar
    final appBarFinder = find.byType(AppBar);
    expect(appBarFinder, findsOneWidget);

    // Find the title text inside the AppBar
    final titleFinder = find.text("Solve the puzzle");
    expect(titleFinder, findsOneWidget);
  });

  testWidgets('Tile list is generated correctly', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: GamePage()));

    final keys = [1, 2, 3, 4, 5, 6, 7, 8];

    for (var key in keys) {
      expect(find.byKey(ValueKey(key)), findsOneWidget);
      expect(find.text('$key'), findsOneWidget);
    }
  });

  test('initTileList generates a valid puzzle', () {
    List<int> puzzle = initTileList();

    expect(puzzle.length, 9); // The puzzle should have 9 elements

    // The puzzle should contain all the numbers from 0 to 8 exactly once
    for (int i = 0; i < 9; i++) {
      expect(puzzle.contains(i), isTrue);
    }

    // The number of inversions should be even
    int inversions = 0;
    for (int i = 0; i < 9; i++) {
      for (int j = i + 1; j < 9; j++) {
        if (puzzle[i] != 0 && puzzle[j] != 0 && puzzle[i] > puzzle[j]) {
          inversions++;
        }
      }
    }
    expect(inversions % 2, 0);
  });
}
