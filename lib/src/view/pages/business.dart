import 'package:flutter/material.dart';
import 'package:slashit/src/resources/colors.dart';
import 'package:slashit/src/resources/text_styles.dart';
import 'package:slashit/src/utils/homeExtra.dart';
import 'package:slashit/src/view/pages/create_payment.dart';

class Business extends StatefulWidget {
  @override
  _BusinessState createState() => _BusinessState();
}

class _BusinessState extends State<Business> {
  int value = 5000;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _header(),
            SizedBox(
              height: 20,
            ),
            _body(),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 5, bottom: 5),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Recents,",
                  style: shopperText4,
                ),
              ),
            ),
            _recentPayments(),
          ],
        ),
      ),
    );
  }

  _header() {
    return Card(
      child: Container(
        height: 100,
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            Container(
              width: 55,
              height: 55,
              margin: EdgeInsets.only(top: 35, left: 5),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png"))),
            ),
            Container(
              margin: EdgeInsets.only(top: 55, left: 65),
              child: Text(
                "Business, Shuvojit Kar",
                style: userTitle,
              ),
            ),
            Positioned(
              right: 1,
              bottom: 15,
              child: PopupMenuButton<Option>(
                onSelected: (option) {},
                itemBuilder: (BuildContext context) {
                  return business.map((Option option) {
                    return PopupMenuItem<Option>(
                      value: option,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(option.icon, size: 20.0, color: PrimrayColor),
                          SizedBox(width: 10),
                          Text(option.title),
                        ],
                      ),
                    );
                  }).toList();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  _body() {
    return Container(
      width: double.infinity,
      height: 280,
      margin: EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black87),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 35,
            margin: EdgeInsets.only(left: 10, top: 10, right: 10),
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Center(
              child: Text(
                "Balance",
                style: shopperText1,
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Center(
            child: Text(
              "NGN $value",
              style: shopperText2,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              "AVAILABLE",
              style: businessText1,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Divider(color: Colors.black26),
          ),
          SizedBox(
            height: 20,
          ),
          OutlineButton(
            onPressed: () =>
                Navigator.pushNamed(context, CreatePayemts.routeName),
            shape: StadiumBorder(),
            borderSide: BorderSide(
                color: Colors.grey, width: 1, style: BorderStyle.solid),
            child: Text(
              "     Create Payments     ",
              style: shopperText3,
            ),
          ),
        ],
      ),
    );
  }

  _recentPayments() {
    return Container(
        height: 250,
        margin: EdgeInsets.only(left: 15, right: 15),
        decoration: BoxDecoration(border: Border.all(color: Colors.black87)),
        child: Column(
          children: <Widget>[
            MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: Container(
                height: 220,
                child: ListView(
                  children: List<Widget>.generate(12, (index) {
                    return _data();
                  }),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 15, top: 5),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "View All",
                  style: shopperText5,
                ),
              ),
            ),
          ],
        ));
  }

  _data() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 5, top: 5, left: 5),
      color: creemWhite,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Text(
              "JUNE 26",
              style: businessText2,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "Sneakers & jeans",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: businessText2,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              "NGN 1200",
              style: businessText2,
            ),
          )
        ],
      ),
    );
  }
}
