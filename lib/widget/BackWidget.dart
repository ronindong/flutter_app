import 'package:flutter/material.dart';

/*
 * 返回组件
 */
class BackWidget extends StatelessWidget {
  final Widget child;

  BackWidget({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: this.child,
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}
