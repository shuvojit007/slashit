import 'package:flutter/material.dart';
import 'package:slashit/src/blocs/transactions.dart';
import 'package:slashit/src/models/transaction.dart';
import 'package:slashit/src/resources/text_styles.dart';
import 'package:slashit/src/utils/number.dart';
import 'package:slashit/src/utils/timeformat.dart';
import 'package:slashit/src/view/common/transactionsDetails.dart';

class Transactions extends StatefulWidget {
  static const routeName = "/transactions";
  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  TransactionsBloc _bloc;
  ScrollController _controller = ScrollController();
  bool scrlDown = true;
  int offset = 0;

  _scrollListener() async {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      print(" Scroll Lister FetchMore Called");
      offset = offset + 1;
      _bloc.featchAllTransctions(20, offset);
    }
  }

  _progressDialog() {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
            margin: EdgeInsets.only(bottom: 30),
            child: CircularProgressIndicator()));
  }

  @override
  void initState() {
    _bloc = TransactionsBloc();
    _bloc.featchAllTransctions(20, 0);
    _controller.addListener(_scrollListener);
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
        title: Text("Transactions", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Stack(
        children: <Widget>[
          StreamBuilder(
            stream: _bloc.allTransaction,
            builder: (context, AsyncSnapshot<List<Result>> snapshot) {
              if (snapshot.hasData && snapshot.data.length > 0) {
                return ListView.builder(
                    controller: _controller,
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      return _transactionsView(snapshot.data[index]);
                    });
              } else if (snapshot.hasData) {
                return Center(
                    child: Text("You have no transaction history yet"));
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
          StreamBuilder<bool>(
            stream: _bloc.isMoreLoading,
            initialData: false,
            builder: (context, snapshot) {
              if (!snapshot.data) {
                return Container();
              } else {
                return _progressDialog();
              }
            },
          ),
        ],
      ),
    );
  }

  _transactionsView(Result data) {
    return Card(
      key: Key(data.id),
      child: GestureDetector(
        onTap: () => _goToTransactionDetails(data),
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
                      "₦ ${formatNumberValue(data.amount)}",
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
