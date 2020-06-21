import 'package:flutter/material.dart';
import 'package:hive/hive.dart';


part 'scores_data.g.dart';

@HiveType()
class ScoresData {

  @HiveField(0)
  final String username;

  @HiveField(1)
  final String score;

   @HiveField(2)
  final String date;

  ScoresData({@required this.username,@required this.score, @required this.date});

}

