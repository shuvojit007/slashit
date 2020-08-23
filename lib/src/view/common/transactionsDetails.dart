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
                          color: Color(0xFFDEFFDF),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Center(
                        child: Text(
                          "  ${widget.data.status}  ",
                          style: TransactionDetials3,
                        ),
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
}
