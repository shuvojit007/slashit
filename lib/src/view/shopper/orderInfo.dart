import 'package:flutter/material.dart';
import 'package:slashit/src/resources/text_styles.dart';

class OrderInfo extends StatefulWidget {
  static const routeName = "/orderInfo";
  @override
  _OrderInfoState createState() => _OrderInfoState();
}

class _OrderInfoState extends State<OrderInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order # 216771523"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          Center(
              child: Text(
            "Business Name",
            style: OrderInfo1,
          )),
          SizedBox(
            height: 5,
          ),
          Center(
              child: Text(
            "13 June 2020",
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
              "NGN 2000",
              style: OrderInfo3,
            ),
          ),
        ],
      ),
    );
  }
}
