import 'package:flutter/material.dart';
import 'package:hive/hive.dart';


part 'card_data.g.dart';

@HiveType()
class CardData {

  @HiveField(0)
  final int index;

  @HiveField(1)
  final bool stay_flipped_open;

   @HiveField(2)
  final bool do_animation;

   @HiveField(3)
  final String image;

  CardData({@required this.index, @required this.stay_flipped_open, @required this.do_animation, @required this.image});
}

