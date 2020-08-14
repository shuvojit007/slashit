import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:slashit/src/di/locator.dart';
import 'package:slashit/src/resources/text_styles.dart';
import 'package:slashit/src/utils/prefmanager.dart';

class DebitCards extends StatefulWidget {
  static const routeName = "/debitcards";
  @override
  _DebitCardsState createState() => _DebitCardsState();
}

class _DebitCardsState extends State<DebitCards> {
  int count = 3;

  String paystackPublicKey = 'pk_test_316f780a38daae0c1cc86c2696dd20fdad714a17';

  int _radioValue = 0;
  CheckoutMethod _method;
  bool _inProgress = false;
  String _cardNumber;
  String _cvv;
  int _expiryMonth = 0;
  int _expiryYear = 0;

  @override
  void initState() {
    PaystackPlugin.initialize(publicKey: paystackPublicKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _header(),
      body: ListView(
        children: <Widget>[
          _body(true),
          _body(false),
          _body(false),
          _body(false),
        ],
      ),
      floatingActionButton: Visibility(
        visible: true,
        child: FloatingActionButton(
          onPressed: () {
            _handleCheckout(context);
          },
          child: Icon(Icons.add),
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
                child: Text("Cancel", style: debitCards),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 20, top: 50),
                  child: Text("Save", style: debitCards),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _body(bool flag) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 1,
      child: Container(
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _cardView("7009"),
            SizedBox(
              width: 10,
            ),
            if (flag) ...[
              Expanded(
                child: Center(
                  child: Text(
                    "Preferred",
                    style: debitCards2,
                  ),
                ),
              )
            ] else ...[
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      OutlineButton(
                        onPressed: () {},
                        shape: StadiumBorder(),
                        borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 0.5,
                            style: BorderStyle.solid),
                        child: const Text(
                          "Make Preferred",
                          style: debitCards4,
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        "Remove Card",
                        style: debitCards5,
                      )
                    ]),
              )
            ],
          ],
        ),
      ),
    );
  }

  _cardView(String card) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 10),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            for (int i = 1; i < 5; i++)
              const Icon(
                Icons.fiber_manual_record,
                color: Colors.black54,
              ),
            SizedBox(
              width: 5,
            ),
            Text(
              card,
              style: debitCards3,
            )
          ]),
    );
  }

  _handleCheckout(BuildContext context) async {
    Charge charge = Charge()
      ..reference = "new card added"
      ..amount = 10000 // In base currency
      ..email = locator<PrefManager>().email
      ..card = _getCardFromUI();

    charge.reference = _getReference();

    try {
      CheckoutResponse response = await PaystackPlugin.checkout(
        context,
        method: CheckoutMethod.card,
        charge: charge,
        fullscreen: false,
        logo: Container(
          width: 50.0,
          height: 50.0,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Center(
            child: Text(
              "Slashit",
              style: splashText1,
            ),
          ),
        ),
      );
      print('Response = $response');
      //  setState(() => _inProgress = false);
      //_updateStatus(response.reference, '$response');
    } catch (e) {
      //   setState(() => _inProgress = false);
      // _showMessage("Check console for error");
      rethrow;
    }
  }

  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }

    return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }

  PaymentCard _getCardFromUI() {
    return PaymentCard(
      number: _cardNumber,
      cvc: _cvv,
      expiryMonth: _expiryMonth,
      expiryYear: _expiryYear,
    );
  }
}
