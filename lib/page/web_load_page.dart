import 'package:flutter/material.dart';
import 'package:flutter_app/bean/gank_today_bean.dart';
import 'package:flutter_app/widget/BackWidget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebLoadPage extends StatefulWidget {
  final ResultBean data;

  WebLoadPage({Key key, this.data}) : super(key: key);

  @override
  State<StatefulWidget> createState() => WebLoadPageState(this.data);
}

class WebLoadPageState extends State<WebLoadPage> {
  ResultBean data;
  bool isLoadFinish = false;
  BuildContext context;

  WebLoadPageState(this.data);

  @override
  void initState() {
    super.initState();
  }

  Widget _getContent() {
    Widget bodyWidget = Stack(
      children: <Widget>[
        WebView(
          initialUrl: this.data.url,
          onWebViewCreated: (controller) {},
          onPageFinished: (url) {
            setState(() {
              isLoadFinish = true;
            });
          },
        ),
        Offstage(
          offstage: isLoadFinish,
          child: SpinKitCircle(
            color: Colors.cyanAccent,
            size: 50.0,
          ),
        )
      ],
    );

    return Scaffold(
      appBar: AppBar(
        leading: BackWidget(
          child: const Icon(Icons.arrow_back),
        ),
        title: Text(
          this.data.desc,
          maxLines: 1,
        ),
      ),
      body: bodyWidget,
    );
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return _getContent();
  }
}
