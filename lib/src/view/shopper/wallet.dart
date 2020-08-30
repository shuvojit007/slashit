import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:slashit/src/di/locator.dart';
import 'package:slashit/src/resources/text_styles.dart';
import 'package:slashit/src/utils/prefmanager.dart';
import 'package:slashit/src/view/shopper/addMoney.dart';

class WalletScreen extends StatefulWidget {
  static const routeName = "/wallet";
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _header(),
      body: Center(
        child: Container(
          height: 350,
          width: 320,
          child: Column(
            children: <Widget>[
              Text(
                  "Pay Instantly from your Wallet balance using this scancode"),
              SizedBox(
                height: 30,
              ),
              QrImage(
                constrainErrorBounds: true,
                embeddedImage: AssetImage("assets/images/slashit.jpeg"),
                data:
                    "{\"type\":\"wallet\",\"id\" :\"${locator<PrefManager>().userID}\"}",
                version: QrVersions.auto,
                size: 250.0,
                gapless: false,
              ),
              Text("Capture QrCode instead")
            ],
          ),
        ),
      ),
    );
  }

  _header() {
    return PreferredSize(
      preferredSize: Size.fromHeight(100),
      child: Container(
        height: 100,
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Padding(
                padding: EdgeInsets.only(left: 20, top: 50),
                child: Icon(
                  FontAwesomeIcons.times,
                  size: 25,
                  color: Colors.black54,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, AddMoney.routeName),
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 20, top: 50),
                  child: Text("Add Money", style: debitCards),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
