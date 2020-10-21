// To parse this JSON data, do
//
//     final website = websiteFromMap(jsonString);

import 'dart:convert';

Website websiteFromMap(String str) => Website.fromMap(json.decode(str));

String websiteToMap(Website data) => json.encode(data.toMap());

class Website {
  Website({
    this.code,
    this.message,
    this.success,
    this.count,
    this.result,
  });

  String code;
  String message;
  bool success;
  int count;
  List<Result> result;

  factory Website.fromMap(Map<String, dynamic> json) => Website(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        success: json["success"] == null ? null : json["success"],
        count: json["count"] == null ? null : json["count"],
        result: json["result"] == null
            ? null
            : List<Result>.from(json["result"].map((x) => Result.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
        "success": success == null ? null : success,
        "count": count == null ? null : count,
        "result": result == null
            ? null
            : List<dynamic>.from(result.map((x) => x.toMap())),
      };
}

class Result {
  Result({
    this.title,
    this.img,
    this.link,
  });

  String title;
  String img;
  String link;

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        title: json["title"] == null ? null : json["title"],
        img: json["img"] == null ? "" : json["img"],
        link: json["link"] == null ? null : json["link"],
      );

  Map<String, dynamic> toMap() => {
        "title": title == null ? null : title,
        "img": img == null ? "" : img,
        "link": link == null ? null : link,
      };
}
