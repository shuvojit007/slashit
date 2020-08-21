// To parse this JSON data, do
//
//     final transactions = transactionsFromMap(jsonString);

import 'dart:convert';

TransactionsModel transactionsFromMap(String str) =>
    TransactionsModel.fromMap(json.decode(str));

String transactionsToMap(TransactionsModel data) => json.encode(data.toMap());

class TransactionsModel {
  TransactionsModel({
    this.code,
    this.message,
    this.success,
    this.result,
  });

  String code;
  String message;
  bool success;
  List<Result> result;

  factory TransactionsModel.fromMap(Map<String, dynamic> json) =>
      TransactionsModel(
        code: json["code"],
        message: json["message"],
        success: json["success"],
        result: List<Result>.from(json["result"].map((x) => Result.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "message": message,
        "success": success,
        "result": List<dynamic>.from(result.map((x) => x.toMap())),
      };
}

class Result {
  Result({
    this.id,
    this.transactionId,
    this.reference,
    this.status,
    this.installment,
    this.paymentDate,
    this.createdAt,
    this.shopper,
    this.order,
  });

  String id;
  String transactionId;
  String reference;
  String status;
  int installment;
  String paymentDate;
  String createdAt;
  Shopper shopper;
  Order order;

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        id: json["_id"],
        transactionId: json["transactionId"],
        reference: json["reference"],
        status: json["status"],
        installment: json["installment"],
        paymentDate: json["paymentDate"],
        createdAt: json["createdAt"],
        shopper: Shopper.fromMap(json["shopper"]),
        order: Order.fromMap(json["order"]),
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "transactionId": transactionId,
        "reference": reference,
        "status": status,
        "installment": installment,
        "paymentDate": paymentDate,
        "createdAt": createdAt,
        "shopper": shopper.toMap(),
        "order": order.toMap(),
      };
}

class Order {
  Order({
    this.createdAt,
    this.orderId,
    this.attachment,
    this.title,
    this.note,
    this.shippingAddress,
    this.desc,
    this.quantity,
    this.amount,
    this.status,
    this.totalLateFee,
    this.currency,
    this.authorizationCode,
    this.isRequested,
    this.type,
  });

  String createdAt;
  String orderId;
  String attachment;
  String title;
  String note;
  String shippingAddress;
  String desc;
  int quantity;
  int amount;
  String status;
  int totalLateFee;
  String currency;
  String authorizationCode;
  bool isRequested;
  String type;

  factory Order.fromMap(Map<String, dynamic> json) => Order(
        createdAt: json["createdAt"],
        orderId: json["orderId"],
        attachment: json["attachment"],
        title: json["title"],
        note: json["note"],
        shippingAddress: json["shippingAddress"],
        desc: json["desc"],
        quantity: json["quantity"],
        amount: json["amount"],
        status: json["status"],
        totalLateFee: json["totalLateFee"],
        currency: json["currency"],
        authorizationCode: json["authorizationCode"],
        isRequested: json["isRequested"],
        type: json["type"],
      );

  Map<String, dynamic> toMap() => {
        "createdAt": createdAt,
        "orderId": orderId,
        "attachment": attachment,
        "title": title,
        "note": note,
        "shippingAddress": shippingAddress,
        "desc": desc,
        "quantity": quantity,
        "amount": amount,
        "status": status,
        "totalLateFee": totalLateFee,
        "currency": currency,
        "authorizationCode": authorizationCode,
        "isRequested": isRequested,
        "type": type,
      };
}

class Shopper {
  Shopper({
    this.firstname,
    this.lastname,
    this.email,
    this.id,
  });

  String firstname;
  String lastname;
  String email;
  String id;

  factory Shopper.fromMap(Map<String, dynamic> json) => Shopper(
        firstname: json["firstname"],
        lastname: json["lastname"],
        email: json["email"],
        id: json["_id"],
      );

  Map<String, dynamic> toMap() => {
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "_id": id,
      };
}
