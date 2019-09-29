/**
 * 主题选项
 */
import 'dart:math';

import 'package:flutter/material.dart';

final List<Color> themeList = [
  Colors.red,
  Colors.teal,
  Colors.pink,
  Colors.amber,
  Colors.orange,
  Colors.green,
  Colors.blue,
  Colors.lightBlue,
  Colors.purple,
  Colors.deepPurple,
  Colors.indigo,
  Colors.cyan,
  Colors.brown,
  Colors.blueGrey
];

Color getRandomColor() => themeList[Random().nextInt(themeList.length)];

final TextStyle textStyleWhite = TextStyle(
  color: Colors.white,
);
