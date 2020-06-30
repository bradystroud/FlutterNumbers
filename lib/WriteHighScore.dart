// Write score to JSON
import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:path_provider/path_provider.dart';

class ScoreModel {
  int moveCount;
  int time;

  ScoreModel({this.moveCount, this.time});

  ScoreModel.fromJson(Map<String, dynamic> json)
      : moveCount = json['moveCount'],
        time = json['time'];

  Map<String, dynamic> toJson() => {
        'moveCount': moveCount,
        'time': time,
      };
}

Future<ScoreModel> readHighScore() async {
  print("Made it here");
  try {
    Directory dir = await getApplicationDocumentsDirectory();
    File file = File('${dir.path}/highscores.txt');
    // File file = File('highscores.txt');

    // Read the file.
    if (await file.exists()) {
      print("File Exists so hard bro");
      // Read file
      String contents = await file.readAsString();
      print(contents);

      Map<String, dynamic> contentDecoded = jsonDecode(contents);
      print("I can read lol");
      print(contentDecoded.toString());
      var highScoreParsed = ScoreModel.fromJson(contentDecoded);

      return highScoreParsed;
    } else {
      print("no File found");
      return ScoreModel(moveCount: 0, time: 0);
    }
  } catch (e) {
    print("  ERROR  "*10);
    // If encountering an error, return 0.
    return ScoreModel(moveCount: 0, time: 0);
  }
}

Future<ScoreModel> writeHighScore(moveCount, time) async {
  ScoreModel highScores = ScoreModel(moveCount: moveCount, time: time);
  Directory dir = await getApplicationDocumentsDirectory();

  ScoreModel oldScores = await readHighScore();

  File('${dir.path}/highscores.txt').create().then((File file) async {
  // File('highscores.txt').create().then((File file) async {
    
    if (oldScores.moveCount == 0) {
      file.writeAsString(jsonEncode(highScores.toJson()));
      print("NEW VALUES WRITTEN");
    }
    if (oldScores.time > time) {
      file.writeAsString(jsonEncode(highScores.toJson()));
    }
  });

  return oldScores;
}
