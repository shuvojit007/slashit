import 'package:flutter/material.dart';
import 'package:slashit/src/models/upcommingPayments.dart';
import 'package:slashit/src/resources/text_styles.dart';
import 'package:slashit/src/utils/number.dart';
import 'package:slashit/src/utils/timeformat.dart';
import 'package:slashit/src/utils/transactionStatus.dart';

class ShopperTranscDetails extends StatefulWidget {
  Transaction transaction;
  Result result;
  ShopperTranscDetails({this.result, this.transaction});

  @override
  _ShopperTranscDetailsState createState() => _ShopperTranscDetailsState();
}

class _ShopperTranscDetailsState extends State<ShopperTranscDetails> {
  @override
  void initState() {
    print(widget.transaction.id);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaction Details", style: userTitle),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          Center(
            child: Text(
              "${getDateTime(widget.transaction.paymentDate)}",
              style: TransactionDetials1,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          if (widget.transaction.transactionId.isNotEmpty) ...[
            Container(
              height: 30,
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text(
                      "Transaction Id",
                      style: TransactionDetials2,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "${widget.transaction.transactionId}",
                        style: TransactionDetials2,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: Divider(color: Colors.black26),
            ),
          ],
          Container(
            height: 30,
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Text(
                    "Status",
                    style: TransactionDetials2,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: 25,
                      width: 150,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: _statusColor(),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Center(
                        child: _statusView(),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Divider(color: Colors.black26),
          ),
          Container(
            height: 30,
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Text(
                    "Merchant ",
                    style: TransactionDetials2,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      widget.result.business?.business == null
                          ? ""
                          : "${widget.result.business.business?.businessName}",
                      style: TransactionDetials2,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Divider(color: Colors.black26),
          ),
          Container(
            height: 30,
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Text(
                    "Order # ",
                    style: TransactionDetials2,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "${widget.result.orderId} ",
                      style: TransactionDetials4,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Divider(color: Colors.black26),
          ),
          Container(
            height: 30,
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Text(
                    "Amount",
                    style: TransactionDetials2,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "₦ ${formatNumberValue(widget.transaction.amount)} ",
                      style: TransactionDetials2,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Divider(color: Colors.black26),
          ),
          Container(
            height: 30,
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Text(
                    "Payment",
                    style: TransactionDetials2,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "${_getPayment(widget.transaction.installment)} ",
                      style: TransactionDetials2,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _getPayment(int payment) {
    switch (payment) {
      case 0:
        return "1st Installment";
        break;
      case 1:
        return "1st Installment";
        break;
      case 2:
        return "2nd Installment";
        break;
      case 3:
        return "3rd Installment";
        break;
      case 4:
        return "4th Installment";
        break;
      default:
        return "";
    }
  }

  Widget _statusView() {
    String sts = getTransactionStatus(widget.transaction.status);
    if (sts == "PENDING") {
      return Text(
        sts,
        style: TransactionDetials5,
      );
    } else if (sts == "COMPLETED") {
      return Text(
        sts,
        style: TransactionDetials3,
      );
    } else {
      return Text(
        sts,
        style: TransactionDetials6,
      );
    }
  }

  Color _statusColor() {
    String sts = getTransactionStatus(widget.transaction.status);
    if (sts == "PENDING") {
      return Color(0xFFc79200).withOpacity(0.2);
    } else if (sts == "COMPLETED") {
      return Color(0xFFDEFFDF);
    } else {
      return Color(0xFFf98087).withOpacity(0.4);
    }
  }
}
