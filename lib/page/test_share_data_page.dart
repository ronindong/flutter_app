import 'package:flutter/material.dart';
import 'package:flutter_app/widget/BackWidget.dart';
import 'package:flutter_app/widget/ShareDataWidget.dart';

class TestShareDataPage extends StatefulWidget {
  @override
  _TestShareDataPageState createState() => _TestShareDataPageState();
}

class _TestShareDataPageState extends State<TestShareDataPage> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: BackWidget(
            child: Icon(Icons.arrow_back),
          ),
          title: Text("Flutter share Data"),
        ),
        body: Container(
          color: Colors.cyan,
          child: Center(
            child: ShareDataWidget<int>(
              data: count,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 18.0),
                    child: SubShareDataWidget(),
                  ),
                  RaisedButton(
                      child: Text("click change share data"),
                      onPressed: () => setState(() {
                            count++;
                          }))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SubShareDataWidget extends StatefulWidget {
  @override
  _SubShareDataWidgetState createState() => _SubShareDataWidgetState();
}

class _SubShareDataWidgetState extends State<SubShareDataWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightGreen,
      child: Text("SubShareDataWidget get share data: " +
          ShareDataWidget.of<int>(context, isNotify: false).toString()),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("SubShareDataWidget didChangeDependencies change... ");
  }
}
