import 'package:flutter/material.dart';

getTransactionStatus(String status) {
  switch (status) {
    case "PAYMENT_SUCCESS":
      return "COMPLETED";
      break;
    case "PAYOUT_SUCCESS":
      return "COMPLETED";
      break;
    case "PAYOUT_PENDING":
      return "PENDING";
      break;
    case "PAYMENT_PENDING":
      return "PENDING";
      break;
    case "PAYMENT_REFUNDED":
      return "REFUNDED";
      break;
    case "PAYMENT_REFUND_FAILED":
      return "FAILED";
      break;

    default:
      return status;
  }
}

Color getTransactionStatusColor(String status) {
  print("getTransactionStatusColor $status");
  switch (status) {
    case "COMPLETED":
      return Color(0xFFDEFFDF);
      break;
    case "PENDING":
      return Color(0xFFFCF3CF);
      break;
    case "FAILED":
      return Color(0xFFFDEDEC);
      break;
    case "REFUNDED":
      return Color(0xFFFDEDEC);
      break;
    default:
      return Color(0xFFDEFFDF);
  }
}
