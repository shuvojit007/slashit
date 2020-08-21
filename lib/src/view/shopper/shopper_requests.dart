import 'package:flutter/material.dart';
import 'package:slashit/src/blocs/paymentReq.dart';
import 'package:slashit/src/models/paymentReq.dart';
import 'package:slashit/src/resources/text_styles.dart';
import 'package:slashit/src/utils/timeformat.dart';
import 'package:slashit/src/view/business/requestDetails.dart';

class ShopperRequests extends StatefulWidget {
  static const routeName = "/shopper_requests";
  @override
  _ShopperRequeststate createState() => _ShopperRequeststate();
}

class _ShopperRequeststate extends State<ShopperRequests> {
  PaymentReqBloc _bloc;

  @override
  void initState() {
    _bloc = PaymentReqBloc();
    _bloc.fetchAllPaymentReq();
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
        title: Text("Requests"),
      ),
      body: StreamBuilder(
        stream: _bloc.allPaymentReq,
        builder: (context, AsyncSnapshot<List<Result>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext ctx, int index) {
                  return _requestView(snapshot.data[index]);
                });
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  _requestView(Result data) {
    return GestureDetector(
      onTap: () => _goToRequestDetails(data),
      child: Card(
        child: Container(
          height: 80,
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
                      "${data.title}",
                      style: RequestesList1,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "NGN ${data.amount}",
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
                      "${getTime(data.createdAt)}",
                      style: TransactionsList1,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _goToRequestDetails(data) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RequestDetails(
                  data: data,
                )));
    ;
  }
}
