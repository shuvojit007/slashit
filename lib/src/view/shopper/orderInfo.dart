import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:slashit/src/blocs/repayment/repayment_bloc.dart';
import 'package:slashit/src/blocs/repayment/repayment_bloc_event.dart';
import 'package:slashit/src/models/upcommingPayments.dart';
import 'package:slashit/src/repository/user_repository.dart';
import 'package:slashit/src/resources/text_styles.dart';
import 'package:slashit/src/utils/timeformat.dart';
import 'package:slashit/src/view/shopper/shTranscDetails.dart';

class OrderInfo extends StatefulWidget {
  static const routeName = "/orderInfo";
  Result data;

  OrderInfo({this.data});

  @override
  _OrderInfoState createState() => _OrderInfoState();
}

class _OrderInfoState extends State<OrderInfo> {
  List<Color> colors = [Colors.blue, Colors.green, Colors.yellow, Colors.red];
  bool status1, status2, status3, status4;
  ProgressDialog _pr;
  @override
  void initState() {
    _pr = ProgressDialog(context, type: ProgressDialogType.Normal);

    status1 = _checkTransactionStatus(widget.data.transactions[0]);
    status2 = _checkTransactionStatus(widget.data.transactions[1]);
    status3 = _checkTransactionStatus(widget.data.transactions[2]);
    status4 = _checkTransactionStatus(widget.data.transactions[3]);

    super.initState();
  }

  _payNow(String id, int index) async {
    _pr.show();
    bool status = await UserRepository.instance.payNow(id);

    if (status) {
      setState(() {
        if (index == 0) status1 = true;
        if (index == 1) status2 = true;
        if (index == 2) status3 = true;
        if (index == 3) status4 = true;
      });
      BlocProvider.of<RepaymentBloc>(context).add(GetRepayment());
      if (_pr.isShowing()) _pr.hide();
    }
    if (_pr.isShowing()) _pr.hide();
  }

  bool _checkTransactionStatus(Transaction transaction) {
    if (transaction.status == "PAYMENT_SUCCESS") return true;
    if (transaction.status == "PAYMENT_SUCCESS") return true;
    return false;
  }

  bool getStatus(int pos) {
    switch (pos) {
      case 0:
        return status1;
        break;
      case 1:
        return status2;
        break;
      case 2:
        return status3;
        break;
      case 3:
        return status4;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order # ${widget.data.orderId}",
            style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
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
              _transactions(widget.data, widget.data.transactions[i], i),
            SizedBox(
              height: 10,
            ),
            if (widget.data.totalLateFee != 0) ...[_lateFee()]
          ],
        ),
      ),
    );
  }

  Widget _transactions(Result result, Transaction transaction, int i) {
    print(transaction.status);
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ShopperTranscDetails(
                    transaction: transaction,
                    result: result,
                  ))),
      child: Container(
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
                child: GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShopperTranscDetails(
                                transaction: transaction,
                                result: result,
                              ))),
                  child: Container(
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
                ),
              ),
              Container(
                padding: const EdgeInsets.only(right: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "NGN ${(widget.data.amount / 4)}",
                      style: Repayments3,
                    ),
                    if (getStatus(i)) ...[
                      Text("PAID",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.w600))
                    ] else ...[
                      RaisedButton(
                        onPressed: () => _payNow(transaction.id, i),
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
              )
            ],
          ),
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
