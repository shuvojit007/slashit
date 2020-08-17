import 'package:flutter/material.dart';
import 'package:slashit/src/resources/text_styles.dart';
import 'package:slashit/src/view/business/requestDetails.dart';

class Requests extends StatefulWidget {
  static const routeName = "/requests";
  @override
  _RequestsState createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Requests"),
      ),
      body: ListView(
        children: <Widget>[
          _requestView(),
          _requestView(),
          _requestView(),
          _requestView(),
          _requestView(),
          _requestView(),
          _requestView(),
          _requestView(),
          _requestView(),
          _requestView(),
          _requestView(),
          _requestView()
        ],
      ),
    );
  }

  _requestView() {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, RequestDetails.routeName),
      child: Card(
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
                      "Pair of Shoe (Title)",
                      style: RequestesList1,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "NGN 1,0000.00",
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
                      "June 21",
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
}
