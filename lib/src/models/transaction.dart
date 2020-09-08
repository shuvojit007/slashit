// To parse this JSON data, do
//
//     final transactionsModel = transactionsModelFromMap(jsonString);

import 'dart:convert';

TransactionsModel transactionsModelFromMap(String str) =>
    TransactionsModel.fromMap(json.decode(str));

String transactionsModelToMap(TransactionsModel data) =>
    json.encode(data.toMap());

class TransactionsModel {
  TransactionsModel({
    this.code,
    this.message,
    this.count,
    this.success,
    this.result,
  });

  String code;
  String message;
  int count;
  bool success;
  List<Result> result;

  factory TransactionsModel.fromMap(Map<String, dynamic> json) =>
      TransactionsModel(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        count: json["count"] == null ? null : json["count"],
        success: json["success"] == null ? null : json["success"],
        result: json["result"] == null
            ? null
            : List<Result>.from(json["result"].map((x) => Result.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
        "count": count == null ? null : count,
        "success": success == null ? null : success,
        "result": result == null
            ? null
            : List<dynamic>.from(result.map((x) => x.toMap())),
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
    this.amount,
    this.createdAt,
    this.shopper,
    this.business,
    this.order,
  });

  String id;
  String transactionId;
  String reference;
  String status;
  int installment;
  String paymentDate;
  num amount;
  String createdAt;
  Shopper shopper;
  ResultBusiness business;
  Order order;

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        id: json["_id"] == null ? null : json["_id"],
        transactionId:
            json["transactionId"] == null ? null : json["transactionId"],
        reference: json["reference"] == null ? null : json["reference"],
        status: json["status"] == null ? null : json["status"],
        installment: json["installment"] == null ? null : json["installment"],
        paymentDate: json["paymentDate"] == null ? null : json["paymentDate"],
        amount: json["amount"] == null ? null : json["amount"],
        createdAt: json["createdAt"] == null ? null : json["createdAt"],
        shopper:
            json["shopper"] == null ? null : Shopper.fromMap(json["shopper"]),
        business: json["business"] == null
            ? null
            : ResultBusiness.fromMap(json["business"]),
        order: json["order"] == null ? null : Order.fromMap(json["order"]),
      );

  Map<String, dynamic> toMap() => {
        "_id": id == null ? null : id,
        "transactionId": transactionId == null ? null : transactionId,
        "reference": reference == null ? null : reference,
        "status": status == null ? null : status,
        "installment": installment == null ? null : installment,
        "paymentDate": paymentDate == null ? null : paymentDate,
        "amount": amount == null ? null : amount,
        "createdAt": createdAt == null ? null : createdAt,
        "shopper": shopper == null ? null : shopper.toMap(),
        "business": business == null ? null : business.toMap(),
        "order": order == null ? null : order.toMap(),
      };
}

class ResultBusiness {
  ResultBusiness({
    this.business,
  });

  BusinessBusiness business;

  factory ResultBusiness.fromMap(Map<String, dynamic> json) => ResultBusiness(
        business: json["business"] == null
            ? null
            : BusinessBusiness.fromMap(json["business"]),
      );

  Map<String, dynamic> toMap() => {
        "business": business == null ? null : business.toMap(),
      };
}

class BusinessBusiness {
  BusinessBusiness({
    this.bankName,
    this.bankNumber,
    this.businessName,
  });

  dynamic bankName;
  dynamic bankNumber;
  dynamic businessName;

  factory BusinessBusiness.fromMap(Map<String, dynamic> json) =>
      BusinessBusiness(
        bankName: json["bankName"],
        bankNumber: json["bankNumber"],
        businessName: json["businessName"],
      );

  Map<String, dynamic> toMap() => {
        "bankName": bankName,
        "bankNumber": bankNumber,
        "businessName": businessName,
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
  num amount;
  String status;
  int totalLateFee;
  String currency;
  String authorizationCode;
  bool isRequested;
  String type;

  factory Order.fromMap(Map<String, dynamic> json) => Order(
        createdAt: json["createdAt"] == null ? null : json["createdAt"],
        orderId: json["orderId"] == null ? null : json["orderId"],
        attachment: json["attachment"] == null ? null : json["attachment"],
        title: json["title"] == null ? null : json["title"],
        note: json["note"] == null ? null : json["note"],
        shippingAddress:
            json["shippingAddress"] == null ? null : json["shippingAddress"],
        desc: json["desc"] == null ? null : json["desc"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        amount: json["amount"] == null ? null : json["amount"],
        status: json["status"] == null ? null : json["status"],
        totalLateFee:
            json["totalLateFee"] == null ? null : json["totalLateFee"],
        currency: json["currency"] == null ? null : json["currency"],
        authorizationCode: json["authorizationCode"] == null
            ? null
            : json["authorizationCode"],
        isRequested: json["isRequested"] == null ? null : json["isRequested"],
        type: json["type"] == null ? null : json["type"],
      );

  Map<String, dynamic> toMap() => {
        "createdAt": createdAt == null ? null : createdAt,
        "orderId": orderId == null ? null : orderId,
        "attachment": attachment == null ? null : attachment,
        "title": title == null ? null : title,
        "note": note == null ? null : note,
        "shippingAddress": shippingAddress == null ? null : shippingAddress,
        "desc": desc == null ? null : desc,
        "quantity": quantity == null ? null : quantity,
        "amount": amount == null ? null : amount,
        "status": status == null ? null : status,
        "totalLateFee": totalLateFee == null ? null : totalLateFee,
        "currency": currency == null ? null : currency,
        "authorizationCode":
            authorizationCode == null ? null : authorizationCode,
        "isRequested": isRequested == null ? null : isRequested,
        "type": type == null ? null : type,
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
        firstname: json["firstname"] == null ? null : json["firstname"],
        lastname: json["lastname"] == null ? null : json["lastname"],
        email: json["email"] == null ? null : json["email"],
        id: json["_id"] == null ? null : json["_id"],
      );

  Map<String, dynamic> toMap() => {
        "firstname": firstname == null ? null : firstname,
        "lastname": lastname == null ? null : lastname,
        "email": email == null ? null : email,
        "_id": id == null ? null : id,
      };
}
