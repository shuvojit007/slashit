import 'package:flutter/material.dart';
import 'package:slashit/src/models/transaction.dart';
import 'package:slashit/src/resources/text_styles.dart';
import 'package:slashit/src/utils/timeformat.dart';

class TransactionDetails extends StatefulWidget {
  Result data;

  TransactionDetails({this.data});
  @override
  _TransactionDetailsState createState() => _TransactionDetailsState();
}

class _TransactionDetailsState extends State<TransactionDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaction Details"),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              "${getDateTime(widget.data.paymentDate)}",
              style: TransactionDetials1,
            ),
          ),
          Container(
            height: 50,
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Text(
                    "Transaction",
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
            height: 50,
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
                    child: Text(
                      "  ${widget.data.status}  ",
                      style: TransactionDetials3,
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
            height: 50,
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
      ),
    );
  }
}
