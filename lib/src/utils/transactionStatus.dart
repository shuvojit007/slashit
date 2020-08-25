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
    case "PAYMENT_SUCCESS":
      return "PENDING";
      break;
    case "PAYMENT_REFUNDED":
      return "REFUNDED";
      break;
    case "PAYMENT_REFUND_FAILED ":
      return "FAILED";
      break;

    default:
      return status;
  }
}
