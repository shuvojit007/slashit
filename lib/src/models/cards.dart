import 'dart:convert';

Cards cardsFromMap(String str) => Cards.fromMap(json.decode(str));

String cardsToMap(Cards data) => json.encode(data.toMap());

class Cards {
  Cards({
    this.code,
    this.message,
    this.count,
    this.result,
  });

  String code;
  String message;
  int count;
  List<Result> result;

  factory Cards.fromMap(Map<String, dynamic> json) => Cards(
        code: json["code"],
        message: json["message"],
        count: json["count"],
        result: List<Result>.from(json["result"].map((x) => Result.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "message": message,
        "count": count,
        "result": List<dynamic>.from(result.map((x) => x.toMap())),
      };
}

class Result {
  Result({
    this.id,
    this.expMonth,
    this.expYear,
    this.cardType,
    this.last4,
    this.preferred,
  });

  String id;
  String expMonth;
  String expYear;
  String cardType;
  String last4;
  bool preferred;

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        id: json["_id"],
        expMonth: json["exp_month"],
        expYear: json["exp_year"],
        cardType: json["card_type"],
        last4: json["last4"],
        preferred: json["preferred"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "exp_month": expMonth,
        "exp_year": expYear,
        "card_type": cardType,
        "last4": last4,
        "preferred": preferred,
      };
}
