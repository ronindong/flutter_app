import 'package:flutter/material.dart';

Type _typeOf<T>() => T;

class ShareDataWidget<T> extends InheritedWidget {
  T data;

  ShareDataWidget({Key key, @required this.data, Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(ShareDataWidget oldWidget) {
    return oldWidget.data != data;
  }

  static T of<T>(BuildContext context, {bool isNotify = true}) {
    final type = _typeOf<ShareDataWidget<T>>();
    if (isNotify) {
      var widget =
          context.inheritFromWidgetOfExactType(type) as ShareDataWidget<T>;
      return widget.data;
    } else {
      var widget = context
          .ancestorInheritedElementForWidgetOfExactType(ShareDataWidget)
          .widget as ShareDataWidget<T>;
      return widget.data;
    }
  }
}
