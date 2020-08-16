// To parse this JSON data, do
//
//     final features = featuresFromMap(jsonString);

import 'dart:convert';

Features featuresFromMap(String str) => Features.fromMap(json.decode(str));

String featuresToMap(Features data) => json.encode(data.toMap());

class Features {
  Features({
    this.code,
    this.message,
    this.count,
    this.hasNext,
    this.result,
  });

  String code;
  String message;
  int count;
  bool hasNext;
  List<Result> result;

  factory Features.fromMap(Map<String, dynamic> json) => Features(
        code: json["code"],
        message: json["message"],
        count: json["count"],
        hasNext: json["hasNext"],
        result: List<Result>.from(json["result"].map((x) => Result.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "message": message,
        "count": count,
        "hasNext": hasNext,
        "result": List<dynamic>.from(result.map((x) => x.toMap())),
      };

  @override
  String toString() {
    return 'Features{code: $code, message: $message, count: $count, hasNext: $hasNext, result: $result}';
  }
}

class Result {
  Result({
    this.id,
    this.title,
    this.price,
    this.desc,
    this.link,
    this.img,
  });

  String id, title, link;
  int price;
  String desc;
  String img;

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        id: json["id"],
        price: json["price"],
        title: json["title"],
        link: json["link"],
        desc: json["desc"],
        img: json["img"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "price": price,
        "desc": desc,
        "title": title,
        "link": link,
        "img": img,
      };

  @override
  String toString() {
    return 'Result{id: $id, title: $title, link: $link, price: $price, desc: $desc, img: $img}';
  }
}
