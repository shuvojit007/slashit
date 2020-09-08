// To parse this JSON data, do
//
//     final upcommingPayments = upcommingPaymentsFromMap(jsonString);

import 'dart:convert';

UpcommingPayments upcommingPaymentsFromMap(String str) =>
    UpcommingPayments.fromMap(json.decode(str));

String upcommingPaymentsToMap(UpcommingPayments data) =>
    json.encode(data.toMap());

class UpcommingPayments {
  UpcommingPayments({
    this.code,
    this.message,
    this.count,
    this.hasNext,
    this.success,
    this.result,
  });

  String code;
  String message;
  int count;
  bool hasNext;
  bool success;
  List<Result> result;

  factory UpcommingPayments.fromMap(Map<String, dynamic> json) =>
      UpcommingPayments(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        count: json["count"] == null ? null : json["count"],
        hasNext: json["hasNext"] == null ? null : json["hasNext"],
        success: json["success"] == null ? null : json["success"],
        result: json["result"] == null
            ? null
            : List<Result>.from(json["result"].map((x) => Result.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
        "count": count == null ? null : count,
        "hasNext": hasNext == null ? null : hasNext,
        "success": success == null ? null : success,
        "result": result == null
            ? null
            : List<dynamic>.from(result.map((x) => x.toMap())),
      };
}

class Result {
  Result({
    this.orderId,
    this.title,
    this.attachment,
    this.note,
    this.shippingAddress,
    this.createdAt,
    this.desc,
    this.quantity,
    this.amount,
    this.totalLateFee,
    this.business,
    this.status,
    this.type,
    this.isRequested,
    this.authorizationCode,
    this.currency,
    this.transactions,
  });

  String orderId;
  String title;
  String attachment;
  String note;
  String shippingAddress;
  String createdAt;
  String desc;
  int quantity;
  num amount;
  int totalLateFee;
  ResultBusiness business;
  String status;
  String type;
  bool isRequested;
  String authorizationCode;
  String currency;
  List<Transaction> transactions;

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        orderId: json["orderId"] == null ? null : json["orderId"],
        title: json["title"] == null ? null : json["title"],
        attachment: json["attachment"] == null ? null : json["attachment"],
        note: json["note"] == null ? null : json["note"],
        shippingAddress:
            json["shippingAddress"] == null ? null : json["shippingAddress"],
        createdAt: json["createdAt"] == null ? null : json["createdAt"],
        desc: json["desc"] == null ? null : json["desc"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        amount: json["amount"] == null ? null : json["amount"],
        totalLateFee:
            json["totalLateFee"] == null ? null : json["totalLateFee"],
        business: json["business"] == null
            ? null
            : ResultBusiness.fromMap(json["business"]),
        status: json["status"] == null ? null : json["status"],
        type: json["type"] == null ? null : json["type"],
        isRequested: json["isRequested"] == null ? null : json["isRequested"],
        authorizationCode: json["authorizationCode"] == null
            ? null
            : json["authorizationCode"],
        currency: json["currency"] == null ? null : json["currency"],
        transactions: json["transactions"] == null
            ? null
            : List<Transaction>.from(
                json["transactions"].map((x) => Transaction.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "orderId": orderId == null ? null : orderId,
        "title": title == null ? null : title,
        "attachment": attachment == null ? null : attachment,
        "note": note == null ? null : note,
        "shippingAddress": shippingAddress == null ? null : shippingAddress,
        "createdAt": createdAt == null ? null : createdAt,
        "desc": desc == null ? null : desc,
        "quantity": quantity == null ? null : quantity,
        "amount": amount == null ? null : amount,
        "totalLateFee": totalLateFee == null ? null : totalLateFee,
        "business": business == null ? null : business.toMap(),
        "status": status == null ? null : status,
        "type": type == null ? null : type,
        "isRequested": isRequested == null ? null : isRequested,
        "authorizationCode":
            authorizationCode == null ? null : authorizationCode,
        "currency": currency == null ? null : currency,
        "transactions": transactions == null
            ? null
            : List<dynamic>.from(transactions.map((x) => x.toMap())),
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
    this.businessName,
  });

  String businessName;

  factory BusinessBusiness.fromMap(Map<String, dynamic> json) =>
      BusinessBusiness(
        businessName:
            json["businessName"] == null ? null : json["businessName"],
      );

  Map<String, dynamic> toMap() => {
        "businessName": businessName == null ? null : businessName,
      };
}

class Transaction {
  Transaction({
    this.id,
    this.transactionId,
    this.status,
    this.installment,
    this.createdAt,
    this.paymentDate,
    this.reference,
    this.amount,
    this.isRequested,
  });

  String id;
  String transactionId;
  String status;
  int installment;
  String createdAt;
  String paymentDate;
  String reference;
  num amount;
  bool isRequested;

  factory Transaction.fromMap(Map<String, dynamic> json) => Transaction(
        id: json["_id"] == null ? null : json["_id"],
        transactionId:
            json["transactionId"] == null ? null : json["transactionId"],
        status: json["status"] == null ? null : json["status"],
        installment: json["installment"] == null ? null : json["installment"],
        createdAt: json["createdAt"] == null ? null : json["createdAt"],
        paymentDate: json["paymentDate"] == null ? null : json["paymentDate"],
        reference: json["reference"] == null ? null : json["reference"],
        amount: json["amount"] == null ? null : json["amount"],
        isRequested: json["isRequested"] == null ? null : json["isRequested"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id == null ? null : id,
        "transactionId": transactionId == null ? null : transactionId,
        "status": status == null ? null : status,
        "installment": installment == null ? null : installment,
        "createdAt": createdAt == null ? null : createdAt,
        "paymentDate": paymentDate == null ? null : paymentDate,
        "reference": reference == null ? null : reference,
        "amount": amount == null ? null : amount,
        "isRequested": isRequested == null ? null : isRequested,
      };
}
