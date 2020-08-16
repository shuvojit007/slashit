import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UpcomingPayment extends StatefulWidget {
  static const routeName = "/upcoming_payment";
  @override
  _UpcomingState createState() => _UpcomingState();
}

class _UpcomingState extends State<UpcomingPayment> {
  int value = 5000;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Center(
            child: Text(
          'Upcoming Payment',
        )),
        // backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              child: Stack(children: <Widget>[
                new Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  width: double.infinity,
                  height: 100.0,
                  decoration: new BoxDecoration(
                    border: new Border.all(
                        color: Colors.grey[300],
                        width: 2.0,
                        style: BorderStyle.solid),
                    borderRadius: new BorderRadius.horizontal(
                      right: new Radius.circular(20.0),
                    ),
                  ),
                ),
                Container(
                    width: 10,
                    height: 100,
                    margin: EdgeInsets.only(left: 15),
                    color: Colors.blue),
                Container(
                    height: 100,
                    child: Text(
                      '#2333333',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    margin: EdgeInsets.only(left: 40, top: 10)),
                Container(
                    height: 100,
                    child: Text(
                      '27 Jun 2020',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w300, color: Colors.grey[500]),
                    ),
                    margin: EdgeInsets.only(left: 40, top: 60)),
                     Container(
                       width: double.infinity,
                    height: 100,
                    child: Center(
                      widthFactor: double.infinity,
                      child: Text('dfdfd', textAlign: TextAlign.right,),
                    )
                    ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
