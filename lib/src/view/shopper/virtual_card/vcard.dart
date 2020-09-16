import 'package:awesome_card/credit_card.dart';
import 'package:awesome_card/style/card_background.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:slashit/src/blocs/vcard.dart';
import 'package:slashit/src/di/locator.dart';
import 'package:slashit/src/models/vcard.dart';
import 'package:slashit/src/repository/user_repository.dart';
import 'package:slashit/src/resources/str.dart';
import 'package:slashit/src/resources/text_styles.dart';
import 'package:slashit/src/utils/number.dart';
import 'package:slashit/src/utils/prefmanager.dart';
import 'package:slashit/src/utils/showToast.dart';

import 'billingAddress.dart';

class VCard extends StatefulWidget {
  static const routeName = "/VCard";
  @override
  _VCardState createState() => _VCardState();
}

class _VCardState extends State<VCard> {
  VcardBloc _bloc;
  final currentDate = DateTime.now();

  final oldDate =
      new DateTime.fromMillisecondsSinceEpoch(int.parse("1600200142439"));

  PageController _controller =
      PageController(initialPage: 0, viewportFraction: 0.92);

  int page = 0;
  ProgressDialog _pr;
  List<Result> cardResult = [];

  @override
  void initState() {
    _pr = ProgressDialog(context, type: ProgressDialogType.Normal);
    var myDate =
        new DateTime.fromMillisecondsSinceEpoch(int.parse("1600200142439"));
    myDate.add(Duration(hours: 24));

    final difference = oldDate.difference(myDate).inHours;

    print(" difference ${difference}  ");

    _bloc = VcardBloc();
    _bloc.featchAllCard();
    super.initState();
  }

  @override
  void dispose() {
    _bloc?.dispose();
    _controller?.dispose();
    super.dispose();
  }

  _onPageViewChange(int index) {
    page = index;
    print("Current Page: " + page.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        StreamBuilder(
          stream: _bloc.allVcards,
          builder: (context, AsyncSnapshot<List<Result>> snapshot) {
            if (snapshot.hasData && snapshot.data.length > 0) {
              cardResult = snapshot.data;
              return SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 30),
                  Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 10, left: 10),
                        child: IconButton(
                            icon: Icon(Icons.keyboard_backspace,
                                color: Colors.black),
                            onPressed: () => Navigator.pop(context)),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          padding: EdgeInsets.only(top: 10, right: 10),
                          child: PopupMenuButton(
                            elevation: 3.2,
                            onCanceled: () {
                              print('You have not chossed anything');
                            },
                            tooltip: 'This is tooltip',
                            onSelected: optionSelected,
                            itemBuilder: (BuildContext context) {
                              return ['Delete'].map((String title) {
                                return PopupMenuItem(
                                  value: title,
                                  child: Text(title),
                                );
                              }).toList();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: EdgeInsets.only(left: 20, bottom: 10),
                    child: Text(
                      "Valid for 23hr 47m",
                      style: createVcard1,
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    height: 230,
                    color: Colors.grey[100],
                    child: PageView.builder(
                        allowImplicitScrolling: true,
                        controller: _controller,
                        onPageChanged: _onPageViewChange,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext ctx, int index) {
                          return _cardView(snapshot.data[index]);
                        }),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: _goToBillindAddress,
                    child: Container(
                      color: Colors.grey[100],
                      margin: EdgeInsets.only(top: 10),
                      padding: EdgeInsets.only(top: 10, left: 10, bottom: 10, right: 10),
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
                    onTap: _copyCard,
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
              ));
            } else if (snapshot.hasData) {
              return Center(child: Text("You have no virtual card. "));
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator());
          },
        ),

      ],
    ));
  }

  optionSelected(String option) async {
    if (_bloc.vCard != null && _bloc.vCard.length > 0) {
      _pr.show();
      bool result =
          await UserRepository.instance.deleteVCard(_bloc.vCard[page].cardId);
      _pr.hide();
      if (result) {
        _bloc.featchAllCard();
      }
    }
  }

  _copyCard() {
    print(_bloc.vCard);
    if (_bloc.vCard != null && _bloc.vCard.length > 0) {
      showToastMsg(_bloc.vCard[page].toString());
    }
  }

  //data.expiryMonth.toString().substring(2, 4)
  _cardView(Result data) {
    return CreditCard(
      cardNumber: data.cardNo
          .replaceAllMapped(RegExp(r".{4}"), (match) => "${match.group(0)} "),
      cardExpiry:
          "${data.expiryMonth}/${data.expiryYear.toString().substring(2, 4)}",
      cardHolderName: "${locator<PrefManager>().name}",
      cvv: data.cvv,
      bankName: "Limited Use card",
      showBackSide: false,
      amount: "  ${data.currency == "NGN" ? "₦" : "\$"} ${formatNumberValue(double.parse(data.amount))}",
      frontBackground: CardBackgrounds.black,
      backBackground: CardBackgrounds.white,
      showShadow: true,
    );
  }

  _goToBillindAddress() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => BillingAddress()));
  }
}
