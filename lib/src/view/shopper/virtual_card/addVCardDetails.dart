import 'package:flutter/material.dart';
import 'package:slashit/src/di/locator.dart';
import 'package:slashit/src/resources/colors.dart';
import 'package:slashit/src/resources/text_styles.dart';
import 'package:slashit/src/utils/number.dart';
import 'package:slashit/src/utils/prefmanager.dart';

class addVCardDetails extends StatefulWidget {
  @override
  _addVCardDetailsState createState() => _addVCardDetailsState();
}

class _addVCardDetailsState extends State<addVCardDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 40),
              Padding(
                  padding: EdgeInsets.only(top: 10, left: 10),
                  child: IconButton(
                      icon: Icon(Icons.keyboard_backspace, color: Colors.black),
                      onPressed: () => Navigator.pop(context))),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.only(left: 20, bottom: 10),
                child: Text(
                  "How much do you plan on spending?",
                  style: createVcard1,
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 10),
                  child: Text(
                    "Spend limit (₦ ${formatNumberValue(locator<PrefManager>().spendLimit)})",
                    style: createVcard2,
                  )),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 50,
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child: RaisedButton(
                textColor: Colors.white,
                //shape: StadiumBorder(),
                color: PrimaryColor,
                onPressed: () {},
                child: Text(
                    "Total Amount ₦ ${formatNumberValue(locator<PrefManager>().spendLimit)}"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
