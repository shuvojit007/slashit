// To parse this JSON data, do
//
//     final paymentReq = paymentReqFromMap(jsonString);

import 'dart:convert';

PaymentReq paymentReqFromMap(String str) =>
    PaymentReq.fromMap(json.decode(str));

String paymentReqToMap(PaymentReq data) => json.encode(data.toMap());

class PaymentReq {
  PaymentReq({
    this.code,
    this.success,
    this.count,
    this.message,
    this.result,
  });

  String code;
  bool success;
  int count;
  String message;
  List<Result> result;

  factory PaymentReq.fromMap(Map<String, dynamic> json) => PaymentReq(
        code: json["code"] == null ? null : json["code"],
        success: json["success"] == null ? null : json["success"],
        count: json["count"] == null ? null : json["count"],
        message: json["message"] == null ? null : json["message"],
        result: json["result"] == null
            ? null
            : List<Result>.from(json["result"].map((x) => Result.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "code": code == null ? null : code,
        "success": success == null ? null : success,
        "count": count == null ? null : count,
        "message": message == null ? null : message,
        "result": result == null
            ? null
            : List<dynamic>.from(result.map((x) => x.toMap())),
      };
}

class Result {
  Result({
    this.id,
    this.title,
    this.note,
    this.desc,
    this.amount,
    this.attachment,
    this.orderId,
    this.createdAt,
    this.status,
    this.shopper,
  });

  String id;
  String title;
  String note;
  String desc;
  double amount;
  String attachment;
  String orderId;
  String createdAt;
  String status;
  Shopper shopper;

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        note: json["note"] == null ? null : json["note"],
        desc: json["desc"] == null ? null : json["desc"],
        amount: json["amount"] == null ? null : json["amount"].toDouble(),
        attachment: json["attachment"] == null ? null : json["attachment"],
        orderId: json["orderId"] == null ? null : json["orderId"],
        createdAt: json["createdAt"] == null ? null : json["createdAt"],
        status: json["status"] == null ? null : json["status"],
        shopper:
            json["shopper"] == null ? null : Shopper.fromMap(json["shopper"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "note": note == null ? null : note,
        "desc": desc == null ? null : desc,
        "amount": amount == null ? null : amount,
        "attachment": attachment == null ? null : attachment,
        "orderId": orderId == null ? null : orderId,
        "createdAt": createdAt == null ? null : createdAt,
        "status": status == null ? null : status,
        "shopper": shopper == null ? null : shopper.toMap(),
      };
}

class Shopper {
  Shopper({
    this.email,
    this.firstname,
    this.lastname,
    this.mobile,
    this.address,
    this.avater,
    this.role,
  });

  String email;
  String firstname;
  String lastname;
  String mobile;
  dynamic address;
  String avater;
  String role;

  factory Shopper.fromMap(Map<String, dynamic> json) => Shopper(
        email: json["email"] == null ? null : json["email"],
        firstname: json["firstname"] == null ? null : json["firstname"],
        lastname: json["lastname"] == null ? null : json["lastname"],
        mobile: json["mobile"] == null ? null : json["mobile"],
        address: json["address"],
        avater: json["avater"] == null ? null : json["avater"],
        role: json["role"] == null ? null : json["role"],
      );

  Map<String, dynamic> toMap() => {
        "email": email == null ? null : email,
        "firstname": firstname == null ? null : firstname,
        "lastname": lastname == null ? null : lastname,
        "mobile": mobile == null ? null : mobile,
        "address": address,
        "avater": avater == null ? null : avater,
        "role": role == null ? null : role,
      };
}
