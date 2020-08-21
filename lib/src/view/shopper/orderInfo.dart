import 'package:flutter/material.dart';
import 'package:slashit/src/models/upcommingPayments.dart';
import 'package:slashit/src/resources/text_styles.dart';
import 'package:slashit/src/utils/timeformat.dart';

class OrderInfo extends StatefulWidget {
  static const routeName = "/orderInfo";
  Result data;

  OrderInfo({this.data});

  @override
  _OrderInfoState createState() => _OrderInfoState();
}

class _OrderInfoState extends State<OrderInfo> {
  List<Color> colors = [Colors.blue, Colors.green, Colors.yellow, Colors.red];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order # ${widget.data.orderId}"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Center(
                child: Text(
              "${widget.data.business.business.businessName.toString()}",
              style: OrderInfo1,
            )),
            SizedBox(
              height: 5,
            ),
            Center(
                child: Text(
              "${getDateTime(widget.data.createdAt)}",
              style: OrderInfo2,
            )),
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
              height: 5,
            ),
            Center(
              child: Text(
                "NGN ${widget.data.amount}",
                style: OrderInfo3,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 5),
              child: Text(
                "${widget.data.title}",
                style: OrderInfo4,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "${widget.data.desc}",
                style: OrderInfo5,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            for (int i = 0; i < widget.data.transactions.length; i++)
              _transactions(widget.data.transactions[i]),
            SizedBox(
              height: 10,
            ),
            if (widget.data.totalLateFee != 0) ...[_lateFee()]
          ],
        ),
      ),
    );
  }

  Widget _transactions(Transaction transaction) {
    return Container(
      height: 80,
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Card(
        child: Row(
          children: <Widget>[
            Container(
              width: 10,
              color: colors[transaction.installment - 1],
            ),
            Expanded(
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 10, top: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(_getName(transaction.installment),
                            style: Repayments1),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "${getDateTime(transaction.paymentDate)}",
                          style: Repayments2,
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "NGN ${(widget.data.amount / 4)}",
                            style: Repayments3,
                          ),
                          if (transaction.status == "PAYMENT_SUCCESS") ...[
                            Text("PAID",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w600))
                          ],
                          if (transaction.status == "PAYMENT_PENDING") ...[
                            RaisedButton(
                              onPressed: () {},
                              color: Colors.blue,
                              shape: StadiumBorder(),
                              child: Text(
                                "Pay Now",
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _lateFee() {
    return Container(
      height: 80,
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Card(
        child: Row(
          children: <Widget>[
            Container(
              width: 10,
              color: colors[0],
            ),
            Expanded(
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 10, top: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Late Fee", style: Repayments1),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "NGN ${(widget.data.totalLateFee)}",
                            style: Repayments3,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String _getName(int count) {
    switch (count) {
      case 1:
        return "First Installment";
        break;
      case 2:
        return "Second Installment";
        break;
      case 3:
        return "Third Installment";
        break;
      case 4:
        return "Final Installment";
        break;
      default:
        return " ";
    }
  }
}
