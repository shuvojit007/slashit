import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:slashit/src/blocs/paymentReq.dart';
import 'package:slashit/src/models/paymentReq.dart';
import 'package:slashit/src/repository/user_repository.dart';
import 'package:slashit/src/resources/text_styles.dart';
import 'package:slashit/src/utils/timeformat.dart';
import 'package:slashit/src/view/common/requestDetails.dart';

class ShopperRequests extends StatefulWidget {
  static const routeName = "/shopper_requests";
  @override
  _ShopperRequeststate createState() => _ShopperRequeststate();
}

class _ShopperRequeststate extends State<ShopperRequests> {
  PaymentReqBloc _bloc;

  ProgressDialog _pr;

  @override
  void initState() {
    _pr = ProgressDialog(context, type: ProgressDialogType.Normal);
    _bloc = PaymentReqBloc();
    _bloc.fetchAllPaymentReqshopper();
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
    return Card(
      child: Container(
        height: 90,
        margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () => _goToRequestDetails(data),
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
            ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => _goToRequestDetails(data),
                    child: Text(
                      "${getTime(data.createdAt)}",
                      style: TransactionsList1,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          FontAwesomeIcons.timesCircle,
                          size: 35,
                          color: Colors.red,
                        ),
                        onPressed: () => _rejectPaymentReq(data.orderId),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      IconButton(
                        icon: Icon(
                          FontAwesomeIcons.checkCircle,
                          size: 35,
                          color: Colors.green,
                        ),
                        onPressed: () => _acceptPayment(data.orderId),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _acceptPayment(String orderId) async {
    _pr.show();
    await UserRepository.instance.acceptPaymentReq(orderId);
    _bloc.fetchAllPaymentReqshopper();
    _pr.hide();
  }

  _rejectPaymentReq(String orderId) async {
    _pr.show();
    await UserRepository.instance.rejectPaymentReq(orderId);
    _bloc.fetchAllPaymentReqshopper();
    _pr.hide();
  }

  _goToRequestDetails(data) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RequestDetails(
                  data: data,
                )));
  }
}
