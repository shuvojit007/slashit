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
        code: json["code"],
        message: json["message"],
        count: json["count"],
        hasNext: json["hasNext"],
        success: json["success"],
        result: List<Result>.from(json["result"].map((x) => Result.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "message": message,
        "count": count,
        "hasNext": hasNext,
        "success": success,
        "result": List<dynamic>.from(result.map((x) => x.toMap())),
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
    this.business,
    this.amount,
    this.status,
    this.type,
    this.isRequested,
    this.authorizationCode,
    this.totalLateFee,
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
  ResultBusiness business;
  int amount;
  String status;
  String type;
  bool isRequested;
  String authorizationCode;
  int totalLateFee;
  String currency;
  List<Transaction> transactions;

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        orderId: json["orderId"],
        title: json["title"],
        attachment: json["attachment"],
        note: json["note"],
        shippingAddress: json["shippingAddress"],
        createdAt: json["createdAt"],
        desc: json["desc"],
        quantity: json["quantity"],
        business: ResultBusiness.fromMap(json["business"]),
        amount: json["amount"],
        status: json["status"],
        type: json["type"],
        isRequested: json["isRequested"],
        authorizationCode: json["authorizationCode"],
        totalLateFee: json["totalLateFee"],
        currency: json["currency"],
        transactions: List<Transaction>.from(
            json["transactions"].map((x) => Transaction.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "orderId": orderId,
        "title": title,
        "attachment": attachment,
        "note": note,
        "shippingAddress": shippingAddress,
        "createdAt": createdAt,
        "desc": desc,
        "quantity": quantity,
        "business": business.toMap(),
        "amount": amount,
        "status": status,
        "type": type,
        "isRequested": isRequested,
        "authorizationCode": authorizationCode,
        "totalLateFee": totalLateFee,
        "currency": currency,
        "transactions": List<dynamic>.from(transactions.map((x) => x.toMap())),
      };
}

class ResultBusiness {
  ResultBusiness({
    this.business,
  });

  BusinessBusiness business;

  factory ResultBusiness.fromMap(Map<String, dynamic> json) => ResultBusiness(
        business: BusinessBusiness.fromMap(json["business"]),
      );

  Map<String, dynamic> toMap() => {
        "business": business.toMap(),
      };
}

class BusinessBusiness {
  BusinessBusiness({
    this.businessName,
  });

  String businessName;

  factory BusinessBusiness.fromMap(Map<String, dynamic> json) =>
      BusinessBusiness(
        businessName: json["businessName"],
      );

  Map<String, dynamic> toMap() => {
        "businessName": businessName,
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
    this.isRequested,
  });

  String id;
  String transactionId;
  String status;
  int installment;
  String createdAt;
  String paymentDate;
  String reference;
  bool isRequested;

  factory Transaction.fromMap(Map<String, dynamic> json) => Transaction(
        id: json["_id"],
        transactionId: json["transactionId"],
        status: json["status"],
        installment: json["installment"],
        createdAt: json["createdAt"],
        paymentDate: json["paymentDate"],
        reference: json["reference"],
        isRequested: json["isRequested"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "transactionId": transactionId,
        "status": status,
        "installment": installment,
        "createdAt": createdAt,
        "paymentDate": paymentDate,
        "reference": reference,
        "isRequested": isRequested,
      };
}
