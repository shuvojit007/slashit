import 'package:flutter/material.dart';
import 'package:slashit/src/di/locator.dart';
import 'package:slashit/src/models/transaction.dart';
import 'package:slashit/src/resources/text_styles.dart';
import 'package:slashit/src/utils/number.dart';
import 'package:slashit/src/utils/prefmanager.dart';
import 'package:slashit/src/utils/timeformat.dart';
import 'package:slashit/src/utils/transactionStatus.dart';

class TransactionDetails extends StatefulWidget {
  Result data;

  TransactionDetails({this.data});
  @override
  _TransactionDetailsState createState() => _TransactionDetailsState();
}

class _TransactionDetailsState extends State<TransactionDetails> {
  @override
  void initState() {
    print(widget.data.transactionId);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text("Transaction Details", style: TextStyle(color: Colors.black)),
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
              "${getDateTime(widget.data.paymentDate)}",
              style: TransactionDetials1,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            margin: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Divider(color: Colors.black26),
          ),
          SizedBox(
            height: 10,
          ),
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
                      "${widget.data.transactionId}",
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
          SizedBox(
            height: 10,
          ),
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
          if (locator<PrefManager>().role == "shopper") ...[
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
                        "${widget.data.business.business.businessName}",
                        style: TransactionDetials2,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ] else ...[
            Container(
              height: 30,
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text(
                      "To ",
                      style: TransactionDetials2,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "${widget.data.shopper.firstname} ${widget.data.shopper.lastname}",
                        style: TransactionDetials2,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
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
          SizedBox(
            height: 10,
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
                      "${widget.data.order.orderId} ",
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
          SizedBox(
            height: 10,
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
                      "₦ ${formatNumberValue(widget.data.amount)} ",
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
      ),
    );
  }

  Widget _statusView() {
    String sts = getTransactionStatus(widget.data.status);
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
    String sts = getTransactionStatus(widget.data.status);
    if (sts == "PENDING") {
      return Color(0xFFfec174);
    } else if (sts == "COMPLETED") {
      return Color(0xFFDEFFDF);
    } else {
      return Color(0xFFf98087);
    }
  }
}
