import 'package:flutter/material.dart';
import 'package:flutter_app/widget/BackWidget.dart';

class AnimPage extends StatefulWidget {
  @override
  _AnimPageState createState() => _AnimPageState();
}

class _AnimPageState extends State<AnimPage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
  }

  Animation<double> _getAnim() {
    Animation<double> animation =
        Tween(begin: 1.0, end: 50.0).animate(controller)
          ..addListener(() {
            setState(() {});
          });
    return animation;
  }

  Animation<double> _getCurvesAnim() {
    Animation<double> curveAnim =
        CurvedAnimation(parent: controller, curve: Curves.bounceInOut);
    curveAnim = Tween(begin: 1.0, end: 100.0).animate(curveAnim)
      ..addListener(() {
        setState(() {});
      });
    return curveAnim;
  }

  @override
  Widget build(BuildContext context) {
    controller.forward();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: BackWidget(
            child: Icon(Icons.arrow_back),
          ),
          title: Text('动画测试'),
        ),
        body: Center(
            child: Column(
          children: <Widget>[
            Image.asset(
              "images/icon_placehold.png",
              width: _getAnim().value,
              height: _getAnim().value,
            ),
            Image.asset(
              "images/icon_placehold.png",
              width: _getCurvesAnim().value,
              height: _getCurvesAnim().value,
            ),
            AnimImage(
              animation: _getCurvesLinearAnim(),
            ),
            AnimatedBuilder(
                animation: _getCurvesEaseAnim(),
                child: Image.asset(
                  "images/icon_placehold.png",
                ),
                builder: (context, child) {
                  return Center(
                    child: Container(
                      child: child,
                      width: _getCurvesEaseAnim().value,
                      height: _getCurvesEaseAnim().value,
                    ),
                  );
                })
          ],
        )),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Animation<double> _getCurvesLinearAnim() {
    Animation<double> curveAnim =
        CurvedAnimation(parent: controller, curve: Curves.easeIn);
    curveAnim = Tween(begin: 1.0, end: 150.0).animate(curveAnim);
    controller.forward();
    return curveAnim;
  }

  Animation<double> _getCurvesEaseAnim() {
    Animation<double> curveAnim =
        CurvedAnimation(parent: controller, curve: Curves.easeInOutSine);
    curveAnim = Tween(begin: 1.0, end: 200.0).animate(curveAnim);
    controller.forward();
    return curveAnim;
  }
}

class AnimImage extends AnimatedWidget {
  AnimImage({Key key, Animation<double> animation})
      : super(key: key, listenable: animation) {}

  @override
  Widget build(BuildContext context) {
    final Animation<double> anim = listenable;

    return Center(
        child: Image.asset(
      "images/icon_placehold.png",
      width: anim.value,
      height: anim.value,
    ));
  }
}
