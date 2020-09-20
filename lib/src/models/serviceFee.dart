// To parse this JSON data, do
//
//     final serviceFee = serviceFeeFromMap(jsonString);

import 'dart:convert';

List<ServiceFee> serviceFeeFromMap(String str) =>
    List<ServiceFee>.from(json.decode(str).map((x) => ServiceFee.fromMap(x)));

String serviceFeeToMap(List<ServiceFee> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class ServiceFee {
  ServiceFee({
    this.currency,
    this.symbol,
    this.serviceChargeFlat,
    this.serviceChargePercentage,
  });

  String currency;
  String symbol;
  num serviceChargeFlat;
  num serviceChargePercentage;

  factory ServiceFee.fromMap(Map<String, dynamic> json) => ServiceFee(
        currency: json["currency"] == null ? null : json["currency"],
        serviceChargeFlat: json["serviceChargeFlat"] == null
            ? null
            : json["serviceChargeFlat"],
        symbol: json["symbol"] == null ? null : json["symbol"],
        serviceChargePercentage: json["serviceChargePercentage"] == null
            ? null
            : json["serviceChargePercentage"],
      );

  Map<String, dynamic> toMap() => {
        "currency": currency == null ? null : currency,
        "serviceChargeFlat":
            serviceChargeFlat == null ? null : serviceChargeFlat,
        "symbol": symbol == null ? null : symbol,
        "serviceChargePercentage":
            serviceChargePercentage == null ? null : serviceChargePercentage,
      };

  @override
  String toString() {
    return 'ServiceFee{currency: $currency, serviceChargeFlat: $serviceChargeFlat, symbol: $symbol, serviceChargePercentage: $serviceChargePercentage}';
  }
}
