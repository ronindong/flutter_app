import 'package:flutter/material.dart';

class ItemWidgetBean {
  String name;
  IconData iconData;
  StatefulWidget page;

  ItemWidgetBean(
      {@required String name,
      @required IconData iconData,
      @required Widget page}) {
    this.name = name;
    this.iconData = iconData;
    this.page = page;
  }
}
