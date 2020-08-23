// To parse this JSON data, do
//
//     final bankList = bankListFromMap(jsonString);

import 'dart:convert';

BankList bankListFromMap(String str) => BankList.fromMap(json.decode(str));

String bankListToMap(BankList data) => json.encode(data.toMap());

class BankList {
  BankList({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory BankList.fromMap(Map<String, dynamic> json) => BankList(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toMap())),
      };

  @override
  String toString() {
    return 'BankList{status: $status, message: $message, data: $data}';
  }
}

class Datum {
  Datum({
    this.name,
    this.slug,
    this.code,
    this.longcode,
    this.gateway,
    this.payWithBank,
    this.active,
    this.isDeleted,
    this.country,
    this.currency,
    this.type,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  dynamic name;
  dynamic slug;
  dynamic code;
  dynamic longcode;
  dynamic gateway;
  bool payWithBank;
  bool active;
  bool isDeleted;
  Country country;
  Currency currency;
  Type type;
  int id;
  DateTime createdAt;
  DateTime updatedAt;

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        name: json["name"] == null ? null : json["name"],
        slug: json["slug"] == null ? null : json["slug"],
        code: json["code"] == null ? null : json["code"],
        longcode: json["longcode"] == null ? null : json["longcode"],
        gateway: json["gateway"] == null ? null : json["gateway"],
        payWithBank:
            json["pay_with_bank"] == null ? null : json["pay_with_bank"],
        active: json["active"] == null ? null : json["active"],
        isDeleted: json["is_deleted"] == null ? null : json["is_deleted"],
        country:
            json["country"] == null ? null : countryValues.map[json["country"]],
        currency: json["currency"] == null
            ? null
            : currencyValues.map[json["currency"]],
        type: json["type"] == null ? null : typeValues.map[json["type"]],
        id: json["id"] == null ? null : json["id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "name": name == null ? null : name,
        "slug": slug == null ? null : slug,
        "code": code == null ? null : code,
        "longcode": longcode == null ? null : longcode,
        "gateway": gateway == null ? null : gateway,
        "pay_with_bank": payWithBank == null ? null : payWithBank,
        "active": active == null ? null : active,
        "is_deleted": isDeleted == null ? null : isDeleted,
        "country": country == null ? null : countryValues.reverse[country],
        "currency": currency == null ? null : currencyValues.reverse[currency],
        "type": type == null ? null : typeValues.reverse[type],
        "id": id == null ? null : id,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
      };

  @override
  String toString() {
    return 'Datum{name: $name, slug: $slug, code: $code, longcode: $longcode, gateway: $gateway, payWithBank: $payWithBank, active: $active, isDeleted: $isDeleted, country: $country, currency: $currency, type: $type, id: $id, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}

enum Country { NIGERIA }

final countryValues = EnumValues({"Nigeria": Country.NIGERIA});

enum Currency { NGN }

final currencyValues = EnumValues({"NGN": Currency.NGN});

enum Type { NUBAN }

final typeValues = EnumValues({"nuban": Type.NUBAN});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }

  @override
  String toString() {
    return 'EnumValues{map: $map, reverseMap: $reverseMap}';
  }
}
