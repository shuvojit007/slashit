import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:slashit/src/blocs/paymentReq.dart';
import 'package:slashit/src/models/paymentReq.dart';
import 'package:slashit/src/resources/text_styles.dart';
import 'package:slashit/src/utils/number.dart';
import 'package:slashit/src/utils/timeformat.dart';
import 'package:slashit/src/view/common/requestDetails.dart';

class Requests extends StatefulWidget {
  static const routeName = "/requests";
  @override
  _RequestsState createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  PaymentReqBloc _bloc;
  ScrollController _controller = ScrollController();
  ProgressDialog _pr;

  bool scrlDown = true;
  int offset = 0;

  _scrollListener() async {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      print(" Scroll Lister FetchMore Called");
      offset = offset + 1;
      _bloc.fetchAllPaymentReq(20, offset);
    }
  }

  @override
  void initState() {
    _bloc = PaymentReqBloc();
    _bloc.fetchAllPaymentReq(20, 0);
    _pr = ProgressDialog(context, type: ProgressDialogType.Normal);
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
        title: Text("Requests", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Stack(
        children: <Widget>[
          StreamBuilder(
            stream: _bloc.allPaymentReq,
            builder: (context, AsyncSnapshot<List<Result>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    controller: _controller,
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      return _requestView(snapshot.data[index], index);
                    });
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

  _progressDialog() {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
            margin: EdgeInsets.only(bottom: 30),
            child: CircularProgressIndicator()));
  }

  _requestView(Result data, int index) {
    return Card(
      key: Key(data.orderId),
      child: GestureDetector(
        onTap: () => _goToRequestDetails(data),
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
                      "₦ ${formatNumberValue(data.amount)}",
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
                      "${getShortTime(data.createdAt)}",
                      style: TransactionsList1,
                    ),
                    // Text(
                    //   "${getDateTime(data.createdAt)}",
                    //   style: TransactionsList1,
                    // ),
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
