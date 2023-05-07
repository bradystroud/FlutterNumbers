// Write score to JSON
import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:path_provider/path_provider.dart';

class ScoreModel {
  int moveCount = 0;
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

Future<File> getFilePath() async {
  Directory dir = await getApplicationDocumentsDirectory();
  return File('${dir.path}/highscores.txt');
}

Future<ScoreModel> readHighScore() async {
  try {
    var file = await getFilePath();

    if (await file.exists()) {
      String contents = await file.readAsString();

      Map<String, dynamic> contentDecoded = jsonDecode(contents);

      var highScoreParsed = ScoreModel.fromJson(contentDecoded);

      return highScoreParsed;
    } else {
      return ScoreModel(moveCount: 0, time: 0);
    }
  } catch (e) {
    print("  ERROR  " * 10);
    return ScoreModel(moveCount: 0, time: 0);
  }
}

Future<ScoreModel> writeHighScore(moveCount, time) async {
  ScoreModel highScores = ScoreModel(moveCount: moveCount, time: time);
  Directory dir = await getApplicationDocumentsDirectory();

  ScoreModel oldScores = await readHighScore();

  File('${dir.path}/highscores.txt').create().then((File file) async {
    if (oldScores.moveCount == 0) {
      file.writeAsString(jsonEncode(highScores.toJson()));
    }
    if (oldScores.time > time) {
      file.writeAsString(jsonEncode(highScores.toJson()));
    }
  });

  return oldScores;
}
