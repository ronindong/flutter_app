class GankTodayBean {
  List<dynamic> category;
  bool error;
  Map<String, dynamic> results;

  GankTodayBean({this.category, this.error, this.results});

  factory GankTodayBean.fromJson(Map<String, dynamic> json) {
    return GankTodayBean(
        category: json['category'],
        results: json['results'],
        error: json['error']);
  }
}

class ResultBean {
  String id;
  String createAt;
  String desc;
  String publishedAt;
  String source;
  String type;
  String url;
  bool used;
  String who;

  ResultBean(
      {this.id,
      this.createAt,
      this.desc,
      this.publishedAt,
      this.source,
      this.type,
      this.url,
      this.used,
      this.who});

  factory ResultBean.fromJson(Map<String, dynamic> json) {
    return ResultBean(
        id: json['_id'],
        createAt: json['createAt'],
        desc: json['desc'],
        publishedAt: json['publishedAt'],
        source: json['source'],
        type: json['type'],
        used: json['used'],
        who: json['who'],
        url: json['url']);
  }
}
