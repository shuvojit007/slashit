import 'package:flutter/material.dart';
import 'package:slashit/src/blocs/upcommingPayment.dart';
import 'package:slashit/src/models/upcommingPayments.dart';
import 'package:slashit/src/resources/text_styles.dart';
import 'package:slashit/src/utils/timeformat.dart';
import 'package:slashit/src/view/shopper/orderInfo.dart';

class UpcommingRepayments extends StatefulWidget {
  static const routeName = "/repayments";
  @override
  _UpcommingRepaymentsState createState() => _UpcommingRepaymentsState();
}

class _UpcommingRepaymentsState extends State<UpcommingRepayments> {
  List<Color> colors = [Colors.blue, Colors.green, Colors.yellow, Colors.red];
  RepaymentsBloc _bloc;

  @override
  void initState() {
    _bloc = RepaymentsBloc();
    _bloc.featchAllRepayments();
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
          title: Text("Upcoming Repayment"),
        ),
        body: StreamBuilder(
          stream: _bloc.allRepayments,
          builder: (context, AsyncSnapshot<List<Result>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    return _cardView(snapshot.data[index]);
                  });
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator());
          },
        ));
  }

  _cardView(Result data) {
    return GestureDetector(
      onTap: () => _goToOrderDetails(data),
      child: Container(
        height: 100,
        margin: EdgeInsets.only(left: 10, right: 10),
        child: Card(
          child: Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10, top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("# ${data.orderId}", style: Repayments1),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${getDateTime(data.createdAt)}",
                      style: Repayments2,
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Text(
                    "NGN ${data.amount}",
                    style: Repayments3,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _goToOrderDetails(data) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => OrderInfo(
                  data: data,
                )));
  }
}
