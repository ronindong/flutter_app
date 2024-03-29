import 'package:flutter/material.dart';

class TestWidgetPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TestWidgetPageState();
  }
}

class TestWidgetPageState extends State<TestWidgetPage> {
  var widgetList = [];
  var nameValue;

  @override
  void initState() {
    _initData();
    super.initState();
  }

  _initData() {
    widgetList.add(getButton());
    widgetList.add(getDropDownButton());
    widgetList.add(getWrap());
    widgetList.add(getImage());
  }

  _clickRaiseBtn() {
    print("click button...");
  }

  @override
  Widget build(BuildContext context) {
    return buildWillPopScope(context);
  }

  buildWillPopScope(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Button simple"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          IconButton(icon: Icon(Icons.more_horiz), onPressed: () {}),
        ],
      ),
      body: WillPopScope(
          child: Container(
            child: Center(
              child: GridView.builder(
                itemCount: widgetList.length,
                itemBuilder: (context, index) => widgetList[index],
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0),
              ),
            ),
          ),
          onWillPop: () async {
            Navigator.of(context).pop("TestWidgetPage dispose");
            return false;
          }),
    );
  }

  Widget getButton() {
    return Container(
      color: Colors.purple,
      child: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text("浮动按钮"),
              onPressed: _clickRaiseBtn,
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              color: Colors.indigoAccent,
              textColor: Colors.white,
            ),
            RaisedButton(
              child: Text("浮动按钮2"),
              onPressed: _clickRaiseBtn,
              shape: BeveledRectangleBorder(),
              color: Colors.cyanAccent,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget getDropDownButton() {
    return Container(
      color: Colors.brown,
      child: StatefulBuilder(
          builder: (context, _setState) => Center(
                  child: DropdownButton(
                      items: [
                    DropdownMenuItem(
                      child: Text("donghl"),
                      value: 'donghl',
                    ),
                    DropdownMenuItem(
                      child: Text("1234"),
                      value: '1234',
                    ),
                  ],
                      hint: Text(
                        "选择姓名",
                        style: TextStyle(color: Colors.white),
                      ),
                      value: nameValue,
                      onChanged: (t) {
                        print(t);
                        _setState(() {
                          nameValue = t;
                        });
                      }))),
    );
  }

  Widget getWrap() {
    return Container(
      child: Center(
          child: Wrap(
        spacing: 2.0,
        runSpacing: 2.0,
        direction: Axis.horizontal,
        children: <Widget>[
          Chip(label: Text("java")),
          Chip(label: Icon(Icons.laptop_mac)),
          Chip(label: Text("flutter")),
          Chip(label: Text("kotlin")),
          Chip(label: Text("python")),
          Chip(label: Text("c++")),
          Chip(
              label: Image.asset(
            'images/3.0x/icon_placehold.png',
            width: 30,
            height: 20,
          )),
        ],
      )),
      color: Colors.cyan,
    );
  }

  Widget getImage() {
    const url =
        "https://cdn2.jianshu.io/assets/web/nav-logo-4c7bbafe27adc892f3046e6978459bac.png";
    return Container(
      color: Colors.lightGreen,
      child: Center(
        child: FadeInImage.assetNetwork(
            placeholder: 'images/3.0x/icon_placehold.png', image: url),
      ),
    );
  }
}
