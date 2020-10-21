import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:slashit/src/blocs/cards.dart';
import 'package:slashit/src/di/locator.dart';
import 'package:slashit/src/models/cards.dart';
import 'package:slashit/src/repository/user_repository.dart';
import 'package:slashit/src/resources/str.dart';
import 'package:slashit/src/resources/text_styles.dart';
import 'package:slashit/src/utils/prefmanager.dart';
import 'package:slashit/src/widget/dialog/removecard.dart';

class DebitCards extends StatefulWidget {
  static const routeName = "/debitcards";
  @override
  _DebitCardsState createState() => _DebitCardsState();
}

class _DebitCardsState extends State<DebitCards> {
  int count = 0;

  String paystackPublicKey = 'pk_live_e8712bbbc7d4b2c9023fa743ff7d1be002796dc0';
  String _cardNumber;
  String _cvv;
  int _expiryMonth = 0;
  int _expiryYear = 0;

  ProgressDialog _pr;
  CardsBloc _bloc;

  @override
  void initState() {
    _pr = ProgressDialog(context, type: ProgressDialogType.Normal);
    PaystackPlugin.initialize(publicKey: paystackPublicKey);
    _bloc = CardsBloc();
    _bloc.featchAllCards();
    super.initState();
  }

  @override
  void dispose() {
    _pr.hide();
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _header(),
      body: StreamBuilder(
        stream: _bloc.allCards,
        builder: (context, AsyncSnapshot<List<Result>> snapshot) {
          print("snapshot ${snapshot.hasData}");
          if (snapshot.hasData) {
            return Stack(
              children: <Widget>[
                ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      return _body(snapshot.data[index]);
                    }),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    margin: EdgeInsets.only(right: 20, bottom: 50),
                    child: Visibility(
                      visible: snapshot.data.length < 4 ? true : false,
                      child: FloatingActionButton(
                        onPressed: () => _handleCheckout(context),
                        child: Icon(Icons.add),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.only(right: 30, bottom: 20, left: 30),
                    child: Text(
                      Str.cardText,
                      textAlign: TextAlign.justify,
                      style: cardText,
                    ),
                  ),
                )
              ],
            );
          }
//          } else if (snapshot.hasError) {
//            return Align(
//              alignment: Alignment.bottomRight,
//              child: Container(
//                margin: EdgeInsets.only(right: 20, bottom: 20),
//                child: FloatingActionButton(
//                  onPressed: () => _handleCheckout(context),
//                  child: Icon(Icons.add),
//                ),
//              ),
//            );
//          }
          return Center(child: CircularProgressIndicator());
        },
      ),
//
    );
  }

  _header() {
    return PreferredSize(
      preferredSize: Size.fromHeight(100),
      child: Container(
        height: 100,
        width: double.infinity,
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: EdgeInsets.only(left: 20, top: 50),
            child: Text("Cancel", style: debitCards),
          ),
        ),
      ),
    );
  }

  _body(Result data) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 1,
      child: Container(
        height: 90,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _cardView("${data.last4}"),
            SizedBox(
              width: 10,
            ),
            if (data.preferred) ...[
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
                        onPressed: () => _setPrefferdCard(data.id),
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
                      GestureDetector(
                        onTap: () => showDialog(
                          context: context,
                          builder: (BuildContext context) => RemoveCard(
                            pushData: _deleteCard,
                            id: data.id,
                          ),
                        ),
                        child: Text(
                          "Remove Card",
                          style: debitCards5,
                        ),
                      )
                    ]),
              )
            ],
          ],
        ),
      ),
    );
  }

  _setPrefferdCard(String id) async {
    _pr.show();
    bool result = await UserRepository.instance.setPrefferdCard(id);
    if (result) {
      await _bloc.featchAllCards();
    }
    _pr.hide();
  }

  _deleteCard(String id) async {
    _pr.show();
    bool result = await UserRepository.instance.deleteCard(id);
    if (result) {
      await _bloc.featchAllCards();
    }
    _pr.hide();
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
          child: Center(
            child: Image.asset(
              "assets/images/slashit.jpeg",
            ),
          ),
        ),
      );

      if (response.reference != null) {
        _pr.show();
        bool result = await UserRepository.instance
            .addCard(response.reference.toString());
        if (result) {
          await _bloc.featchAllCards();
        }
        if (_pr.isShowing()) {
          _pr.hide();
        }
      }
    } catch (e) {
      if (_pr.isShowing()) {
        _pr.hide();
      }
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
