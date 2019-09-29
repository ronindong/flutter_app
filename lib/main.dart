import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/base/theme.dart';
import 'package:flutter_app/page/anim_page.dart';
import 'package:flutter_app/page/test_share_data_page.dart';
import 'package:flutter_app/provide/ThemeProvide.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provide/provide.dart';

import 'bean/item_widget_bean.dart';
import 'page/gank_io_page.dart';
import 'page/test_widget_page.dart';

void main() {
  var themeProvide = ThemeProvide();
  var provides = Providers();

  provides..provide(Provider.function((context) => themeProvide));

  runApp(ProviderNode(child: MyApp(), providers: provides));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Color themeColor = getRandomColor();
    Provide.value<ThemeProvide>(context).changeThemeColor(themeColor);
    return Provide<ThemeProvide>(
      builder: (context, child, scope) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
              primaryColor: Provide.value<ThemeProvide>(context).themeColor,
              iconTheme: IconThemeData(
                  color: Provide.value<ThemeProvide>(context).themeColor)),
          debugShowCheckedModeBanner: false,
          home: MyHomePage(
            title: 'Flutter Demo Home Page',
            themeColor: themeColor,
          ),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  final Color themeColor;

  MyHomePage({Key key, this.title, this.themeColor}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState(this.themeColor);
}

class _MyHomePageState extends State<MyHomePage> {
  List<ItemWidgetBean> datas = [];
  dynamic connectivity;
  bool isOpenSwitchPage = false;
  DateTime backTime;
  Color themeColor;

  _MyHomePageState(this.themeColor);

  void _initData() {
    Future.delayed(Duration(milliseconds: 0)).then((e) {
      setState(() {
        datas.add(ItemWidgetBean(
            name: "基础Widget", iconData: Icons.widgets, page: TestWidgetPage()));
        datas.add(ItemWidgetBean(
            name: "网络库Dio", iconData: Icons.http, page: NetworkPage()));
        datas.add(ItemWidgetBean(
            name: "动画", iconData: Icons.all_out, page: AnimPage()));
        datas.add(ItemWidgetBean(
            name: "数据共享", iconData: Icons.shuffle, page: TestShareDataPage()));
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
          backgroundColor: themeColor,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  Widget _itemWidget(BuildContext context, int index) {
    if (index < datas.length) {
      ItemWidgetBean itemData = datas[index];
      return GestureDetector(
        child: Container(
          color: this.themeColor,
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.lime,
                    child: Icon(itemData.iconData),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${itemData.name}",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ]),
          ),
        ),
        onTap: () => _onItemClick(index, itemData),
      );
    }
    return Text("❎");
  }

  void _onItemClick(int index, ItemWidgetBean itemData) {
    print("pos=+$index");
    if (isOpenSwitchPage) {
      Navigator.push(context, CupertinoPageRoute(builder: (_) => itemData.page))
          .then((value) {
        print(value);
      });
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (_) => itemData.page))
          .then((value) {
        print(value);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        iconTheme: IconThemeData(color: themeColor),
        actions: <Widget>[],
      ),
      body: Builder(
          builder: (context) => WillPopScope(
                child: Center(
                  // Center is a layout widget. It takes a single child and positions it
                  // in the middle of the parent.
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      itemCount: datas.length,
                      itemBuilder: (context, index) =>
                          _itemWidget(context, index),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 10.0),
                    ),
                  ),
                ),
                onWillPop: () async {
                  if (backTime == null ||
                      DateTime.now().difference(backTime) >
                          Duration(seconds: 1)) {
                    backTime = DateTime.now();
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("再点一次退出"),
                      backgroundColor: themeColor,
                    ));
                    return false;
                  }
                  return true;
                },
              )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: themeColor,
        onPressed: () {
          setState(() {
            themeColor = getRandomColor();
            Provide.value<ThemeProvide>(context).changeThemeColor(themeColor);
            isOpenSwitchPage = !isOpenSwitchPage;
          });
        },
        tooltip: 'switch theme style',
        child:
            isOpenSwitchPage ? Icon(Icons.phone_iphone) : Icon(Icons.android),
      ),
    );
  }
}
