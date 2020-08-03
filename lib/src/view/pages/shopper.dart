import 'package:barcode_flutter/barcode_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:slashit/src/repository/user_repository.dart';
import 'package:slashit/src/resources/colors.dart';
import 'package:slashit/src/resources/str.dart';
import 'package:slashit/src/resources/text_styles.dart';
import 'package:slashit/src/utils/homeExtra.dart';
import 'package:slashit/src/widget/cardview.dart';

class Shopper extends StatefulWidget {
  @override
  _ShopperState createState() => _ShopperState();
}

class _ShopperState extends State<Shopper> {
  int value = 5000;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _header(),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: 35,
              margin: EdgeInsets.only(left: 5, right: 5),
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Center(
                child: Text(
                  "Spend up to",
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
              onPressed: () async {
                UserRepository.instance.feachFeatures();
              },
              shape: StadiumBorder(),
              borderSide: BorderSide(
                  color: Colors.grey, width: 1, style: BorderStyle.solid),
              child: Text(
                "     Upcomming Repayments     ",
                style: shopperText3,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: 300,
              height: 50,
              child: Text(
                Str.barcode,
                style: barcodeText,
              ),
            ),
            BarCodeImage(
              params: Code93BarCodeParams("1234ABCDEDGH",
                  lineWidth: 2.00, barHeight: 90.0),
            ),
            SizedBox(
              height: 30,
            ),
            RaisedButton(
              child: Text("Add Card"),
              onPressed: _showCard,
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 5),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Features",
                  style: shopperText4,
                ),
              ),
            ),
            _features(),
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
                "Shopper, Shuvojit Kar",
                style: userTitle,
              ),
            ),
            Positioned(
              right: 1,
              bottom: 15,
              child: PopupMenuButton<Option>(
                onSelected: (option) {},
                itemBuilder: (BuildContext context) {
                  return shopper.map((Option option) {
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

  _showCard() {
    scaffoldKey.currentState.showBottomSheet(
      (context) => Container(
        height: 400,
        child: CardView(),
      ),
    );
  }

  _features() {
    return Container(
      width: double.infinity,
      height: 320,
      margin: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(border: Border.all(color: Colors.black87)),
      child: Column(
        children: <Widget>[
          MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: Container(
              height: 290,
              child: GridView.count(
                crossAxisCount: 4,
                children: List<Widget>.generate(12, (index) {
                  return new GridTile(
                      child: Card(
                    color: Colors.blue.shade200,
                    child: Center(
                      child: Text("item $index"),
                    ),
                  ));
                }),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 5, top: 5),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                "View All",
                style: shopperText5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
