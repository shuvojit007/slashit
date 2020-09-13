import 'package:awesome_card/credit_card.dart';
import 'package:awesome_card/style/card_background.dart';
import 'package:flutter/material.dart';
import 'package:slashit/src/di/locator.dart';
import 'package:slashit/src/resources/str.dart';
import 'package:slashit/src/resources/text_styles.dart';
import 'package:slashit/src/utils/number.dart';
import 'package:slashit/src/utils/prefmanager.dart';

import 'billingAddress.dart';

class VCard extends StatefulWidget {
  @override
  _VCardState createState() => _VCardState();
}

class _VCardState extends State<VCard> {
  PageController _controller =
      PageController(initialPage: 0, viewportFraction: 0.94);
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                "Valid for 23hr 47m",
                style: createVcard1,
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 230,
              color: Colors.grey[100],
              child: PageView(
                allowImplicitScrolling: true,
                controller: _controller,
                children: [
                  CreditCard(
                    cardNumber: "4063 7272 2711 2727",
                    cardExpiry: "10/25",
                    cardHolderName: "${locator<PrefManager>().name}",
                    cvv: "456",
                    bankName: "Limited Use card",
                    showBackSide: false,
                    amount:
                        "  ₦ ${formatNumberValue(locator<PrefManager>().spendLimit)}",
                    frontBackground: CardBackgrounds.black,
                    backBackground: CardBackgrounds.white,
                    showShadow: true,
                  ),
                  CreditCard(
                    cardNumber: "4063 7272 2711 2727",
                    cardExpiry: "10/25",
                    cardHolderName: "${locator<PrefManager>().name}",
                    cvv: "456",
                    bankName: "Limited Use card",
                    showBackSide: false,
                    amount:
                        "  \$ ${formatNumberValue(locator<PrefManager>().spendLimit)}",
                    frontBackground: CardBackgrounds.black,
                    backBackground: CardBackgrounds.white,
                    showShadow: true,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: _goToBillindAddress,
              child: Container(
                color: Colors.grey[100],
                margin: EdgeInsets.only(top: 10),
                padding:
                    EdgeInsets.only(top: 10, left: 10, bottom: 10, right: 10),
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "  Billing",
                        style: createVcard5,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () {},
              child: Column(
                children: <Widget>[
                  Center(
                    child: Icon(
                      Icons.credit_card,
                      size: 50,
                    ),
                  ),
                  Center(child: Text("Copy Card")),
                ],
              ),
            ),
            SizedBox(height: 60),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 10, bottom: 10),
              child: Text(
                Str.createvCardSlug3,
                style: createVcard8,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _goToBillindAddress() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => BillingAddress()));
  }
}
