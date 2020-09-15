// To parse this JSON data, do
//
//     final vcardModel = vcardModelFromMap(jsonString);

import 'dart:convert';

VcardModel vcardModelFromMap(String str) =>
    VcardModel.fromMap(json.decode(str));

String vcardModelToMap(VcardModel data) => json.encode(data.toMap());

class VcardModel {
  VcardModel({
    this.success,
    this.message,
    this.count,
    this.results,
  });

  bool success;
  String message;
  int count;
  List<Result> results;

  factory VcardModel.fromMap(Map<String, dynamic> json) => VcardModel(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        count: json["count"] == null ? null : json["count"],
        results: json["results"] == null
            ? null
            : List<Result>.from(json["results"].map((x) => Result.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "success": success == null ? null : success,
        "message": message == null ? null : message,
        "count": count == null ? null : count,
        "results": results == null
            ? null
            : List<dynamic>.from(results.map((x) => x.toMap())),
      };
}

class Result {
  Result({
    this.id,
    this.cardId,
    this.amount,
    this.cardNo,
    this.currency,
    this.cvv,
    this.expiration,
    this.expiryYear,
    this.expiryMonth,
    this.createdAt,
  });

  String id;
  String cardId;
  String amount;
  String cardNo;
  String currency;
  String cvv;
  String expiration;
  dynamic expiryYear;
  dynamic expiryMonth;
  String createdAt;

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        id: json["_id"] == null ? null : json["_id"],
        cardId: json["cardId"] == null ? null : json["cardId"],
        amount: json["amount"] == null ? null : json["amount"],
        cardNo: json["cardNo"] == null ? null : json["cardNo"],
        currency: json["currency"] == null ? null : json["currency"],
        cvv: json["cvv"] == null ? null : json["cvv"],
        expiration: json["expiration"] == null ? null : json["expiration"],
        expiryYear: json["expiry_year"],
        expiryMonth: json["expiry_month"],
        createdAt: json["createdAt"] == null ? null : json["createdAt"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id == null ? null : id,
        "cardId": cardId == null ? null : cardId,
        "amount": amount == null ? null : amount,
        "cardNo": cardNo == null ? null : cardNo,
        "currency": currency == null ? null : currency,
        "cvv": cvv == null ? null : cvv,
        "expiration": expiration == null ? null : expiration,
        "expiry_year": expiryYear,
        "expiry_month": expiryMonth,
        "createdAt": createdAt == null ? null : createdAt,
      };

  @override
  String toString() {
    return 'Result{id: $id, cardId: $cardId, amount: $amount, cardNo: $cardNo, currency: $currency, cvv: $cvv, expiration: $expiration, expiryYear: $expiryYear, expiryMonth: $expiryMonth, createdAt: $createdAt}';
  }
}
