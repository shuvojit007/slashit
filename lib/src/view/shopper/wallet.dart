import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';

class WalletScreen extends StatefulWidget {
  static const routeName = "/wallet";
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: EdgeInsets.only(top: 50, left: 20),
              child: Icon(
                FontAwesomeIcons.backward,
                size: 30,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: EdgeInsets.only(top: 50, right: 20),
              child: Text("Add Money"),
            ),
          ),
          Center(
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
                    data: "1234567890",
                    version: QrVersions.auto,
                    size: 250.0,
                    gapless: false,
                  ),
                  Text("Capture QrCode instead")
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
