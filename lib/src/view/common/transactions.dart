import 'package:flutter/material.dart';
import 'package:slashit/src/resources/text_styles.dart';

class Transactions extends StatefulWidget {
  static const routeName = "/transactions";
  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transactions"),
      ),
      body: ListView(
        children: <Widget>[
          _transactionsView(),
          _transactionsView(),
          _transactionsView(),
          _transactionsView(),
          _transactionsView(),
          _transactionsView(),
          _transactionsView(),
          _transactionsView(),
          _transactionsView(),
          _transactionsView(),
          _transactionsView(),
          _transactionsView(),
          _transactionsView(),
          _transactionsView(),
          _transactionsView(),
          _transactionsView(),
        ],
      ),
    );
  }

  _transactionsView() {
    return Card(
      child: Container(
        height: 60,
        margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "June 12, 2020",
                    style: TransactionsList1,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "03: 54 AM",
                    style: TransactionsList2,
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "NGN 6,900.00",
                    style: TransactionsList1,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Completed",
                    style: TransactionsList3,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
