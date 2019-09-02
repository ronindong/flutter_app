import 'package:flutter/material.dart';

class BackWidget extends StatefulWidget {
  Widget child;

  BackWidget({Key key, this.child}) : super(key: key);

  @override
  _BackWidgetState createState() => _BackWidgetState(this.child);
}

class _BackWidgetState extends State<BackWidget> {
  Widget child;

  _BackWidgetState(this.child);

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
