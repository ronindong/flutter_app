import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/base/theme.dart';
import 'package:flutter_app/bean/gank_today_bean.dart';
import 'package:flutter_app/widget/BackWidget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'web_load_page.dart';

const HTTP_URL = "http://gank.io/api/today";

class NetworkPage extends StatefulWidget {
  @override
  _NetworkPageState createState() => _NetworkPageState();
}

class _NetworkPageState extends State<NetworkPage>
    with SingleTickerProviderStateMixin {
  GankTodayBean jsonData;
  var loadWidget;
  TabController tabController;
  List<Tab> tabs = List();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 0)).then((value) {
      _requestHttpData();
    });
  }

  _requestHttpData() async {
    var option = BaseOptions(
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      contentType: ContentType.json,
    );

    Dio(option).get<Map<String, dynamic>>(HTTP_URL).then((resp) {
      if (resp?.statusCode == 200) {
        setState(() {
          //解析数据并生成tab控件
          this.jsonData = GankTodayBean.fromJson(resp.data);
          tabs.addAll(this.jsonData.results.keys.map((it) {
            return Tab(
              text: it.toString(),
            );
          }).toList());
          tabController = TabController(length: tabs.length, vsync: this);
        });
      }
    }, onError: (error) {}).catchError((onError) {
      print(onError);
    });
  }

  Widget _itemWidget(BuildContext context, int index, List<dynamic> data) {
    if (index < data.length) {
      var itemData = ResultBean.fromJson(data[index]);
      return GestureDetector(
        child: Container(
          color: Colors.indigoAccent,
          child: Center(
            child: Column(
              children: <Widget>[
                Text(
                  itemData.desc,
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                  maxLines: 3,
                ),
                Text(
                  itemData.url,
                  style: textStyleWhite,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text(
                    itemData.publishedAt,
                    textAlign: TextAlign.right,
                    style: textStyleWhite,
                  ),
                )
              ],
            ),
          ),
        ),
        onTap: () => _onItemClick(index, itemData),
      );
    }
    return Text("❎");
  }

  void _onItemClick(int index, ResultBean itemData) {
    print("pos=$index,data=${itemData.toString()}");
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => WebLoadPage(
                  data: itemData,
                ))).then((value) {
      print(value);
    });
  }

  Widget _getContentWidget() {
    Widget bodyWidget;
    if (jsonData == null) {
      bodyWidget = SpinKitCircle(
        color: Colors.cyanAccent,
        size: 50.0,
      );
    } else {
      bodyWidget = TabBarView(
        children: tabs.map((tab) {
          List<dynamic> data = this.jsonData.results[tab.text];
          return Center(
            child: StaggeredGridView.countBuilder(
              crossAxisCount: 2,
              itemCount: data.length,
              itemBuilder: (context, index) =>
                  _itemWidget(context, index, data),
              staggeredTileBuilder: (index) => StaggeredTile.count(1, 1),
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0,
            ),
          );
        }).toList(),
        controller: tabController,
      );
    }
    return Scaffold(
      appBar: AppBar(
          leading: BackWidget(
            child: Icon(Icons.arrow_back),
          ),
          title: Text('GankIO API'),
          bottom: tabs.length < 1
              ? null
              : TabBar(
                  isScrollable: true,
                  tabs: tabs,
                  controller: tabController,
                )),
      body: bodyWidget,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _getContentWidget();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}
