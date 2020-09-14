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
    this.serviceChargeFlat,
    this.serviceChargePercentage,
  });

  String currency;
  int serviceChargeFlat;
  int serviceChargePercentage;

  factory ServiceFee.fromMap(Map<String, dynamic> json) => ServiceFee(
        currency: json["currency"] == null ? null : json["currency"],
        serviceChargeFlat: json["serviceChargeFlat"] == null
            ? null
            : json["serviceChargeFlat"],
        serviceChargePercentage: json["serviceChargePercentage"] == null
            ? null
            : json["serviceChargePercentage"],
      );

  Map<String, dynamic> toMap() => {
        "currency": currency == null ? null : currency,
        "serviceChargeFlat":
            serviceChargeFlat == null ? null : serviceChargeFlat,
        "serviceChargePercentage":
            serviceChargePercentage == null ? null : serviceChargePercentage,
      };

  @override
  String toString() {
    return 'ServiceFee{currency: $currency, serviceChargeFlat: $serviceChargeFlat, serviceChargePercentage: $serviceChargePercentage}';
  }
}
