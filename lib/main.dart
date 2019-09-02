import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'base/theme.dart';
import 'bean/item_widget_bean.dart';
import 'page/network_page.dart';
import 'page/test_widget_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ItemWidgetBean> datas = [];
  dynamic connectivity;

  void _initData() {
    Future.delayed(Duration(milliseconds: 0)).then((e) {
      setState(() {
        datas.add(ItemWidgetBean(
            name: "基础Widget", iconData: Icons.widgets, page: TestWidgetPage()));
        datas.add(ItemWidgetBean(
            name: "网络库Dio", iconData: Icons.http, page: NetworkPage()));
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _initData();
    _initListener();
  }

  void _initListener() {
    connectivity = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      String tips = "";
      switch (result) {
        case ConnectivityResult.mobile:
          tips = "当前处于移动网络";
          break;
        case ConnectivityResult.wifi:
          tips = "当前处于wifi网络";
          break;
        case ConnectivityResult.none:
          tips = "当前没有网络连接！";
          break;
      }
      Fluttertoast.showToast(
          msg: tips,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: themeList[2],
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  Widget _itemWidget(BuildContext context, int index) {
    if (index < datas.length) {
      var itemData = datas[index];
      return GestureDetector(
        child: Container(
          color: Colors.indigo,
          child: Center(
            child: CircleAvatar(
              backgroundColor: Colors.lightGreenAccent,
              child: Icon(itemData.iconData),
            ),
          ),
        ),
        onTap: () => _onItemClick(index, itemData),
      );
    }
    return Text("❎");
  }

  void _onItemClick(int index, ItemWidgetBean itemData) {
    print("pos=+$index");
    Navigator.push(context, MaterialPageRoute(builder: (_) => itemData.page))
        .then((value) {
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Center(
          child: StaggeredGridView.countBuilder(
            crossAxisCount: 2,
            itemCount: datas.length,
            itemBuilder: (context, index) => _itemWidget(context, index),
            staggeredTileBuilder: (index) => StaggeredTile.count(1, 1),
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: 'Increment',
        child:
            Platform.isAndroid ? Icon(Icons.android) : Icon(Icons.tablet_mac),
      ),
    );
  }
}
