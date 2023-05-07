// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:number_puzzle_game/main.dart';
import 'package:number_puzzle_game/GamePage.dart';

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
}
