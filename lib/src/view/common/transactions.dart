import 'package:flutter/material.dart';
import 'package:slashit/src/blocs/transactions.dart';
import 'package:slashit/src/models/transaction.dart';
import 'package:slashit/src/resources/text_styles.dart';
import 'package:slashit/src/utils/timeformat.dart';
import 'package:slashit/src/view/common/transactionsDetails.dart';

class Transactions extends StatefulWidget {
  static const routeName = "/transactions";
  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  TransactionsBloc _bloc;

  @override
  void initState() {
    _bloc = TransactionsBloc();
    _bloc.featchAllTransctions();
    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transactions"),
      ),
      body: StreamBuilder(
        stream: _bloc.allTransaction,
        builder: (context, AsyncSnapshot<List<Result>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext ctx, int index) {
                  return _transactionsView(snapshot.data[index]);
                });
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  _transactionsView(Result data) {
    return GestureDetector(
      onTap: () => _goToTransactionDetails(data),
      child: Card(
        child: Container(
          height: 70,
          margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Text(
                  "${getDateTime(data.createdAt)}",
                  style: TransactionsList1,
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "NGN ${data.amount}",
                      style: TransactionsList1,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${_getStatus(data.status.toString())}",
                      style: TransactionsList3,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _goToTransactionDetails(data) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TransactionDetails(
                  data: data,
                )));
  }

  _getStatus(String status) {
    switch (status) {
      case "PAYMENT_SUCCESS":
        return "Completed";
        break;
      case "PAYMENT_PENDING":
        return "Pending";
        break;
      case "PAYOUT_SUCCESS":
        return "Completed";
        break;
      case "PAYOUT_PENDING":
        return "Pending";
        break;
      default:
        return status;
        break;
    }
  }
}
