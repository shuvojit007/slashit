import 'dart:math';

import 'package:flutter/material.dart';
import 'package:slashit/src/resources/text_styles.dart';
import 'package:slashit/src/view/shopper/orderInfo.dart';

class UpcommingRepayments extends StatefulWidget {
  static const routeName = "/repayments";
  @override
  _UpcommingRepaymentsState createState() => _UpcommingRepaymentsState();
}

class _UpcommingRepaymentsState extends State<UpcommingRepayments> {
  List<Color> colors = [Colors.blue, Colors.green, Colors.yellow, Colors.red];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upcoming Repayment"),
      ),
      body: ListView(
        children: <Widget>[
          _cardView(),
          _cardView(),
          _cardView(),
          _cardView(),
          _cardView(),
          _cardView(),
          _cardView(),
          _cardView(),
          _cardView(),
          _cardView(),
          _cardView(),
          _cardView(),
          _cardView(),
          _cardView(),
          _cardView(),
          _cardView(),
          _cardView(),
          _cardView(),
          _cardView(),
          _cardView(),
          _cardView(),
          _cardView(),
          _cardView(),
          _cardView(),
          _cardView(),
          _cardView(),
          _cardView(),
          _cardView(),
          _cardView(),
          _cardView(),
        ],
      ),
    );
  }

  _cardView() {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, OrderInfo.routeName),
      child: Container(
        height: 100,
        margin: EdgeInsets.only(left: 10, right: 10),
        child: Card(
          child: Row(
            children: <Widget>[
              Container(
                width: 10,
                color: colors[new Random().nextInt(3)],
              ),
              Expanded(
                child: Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 10, top: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("# 216771523", style: Repayments1),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "24 June 2020",
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
                          "NGN 200,00",
                          style: Repayments3,
                        ),
                      ),
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
}
