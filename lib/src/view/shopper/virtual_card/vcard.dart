import 'dart:async';

import 'package:awesome_card/credit_card.dart';
import 'package:awesome_card/style/card_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jiffy/jiffy.dart';
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
  String time = "";
//  final currentDate = DateTime.now();
//
//  final oldDate =
//      new DateTime.fromMillisecondsSinceEpoch(int.parse("1600200142439"));

  PageController _controller =
      PageController(initialPage: 0, viewportFraction: 0.92);
  StreamSubscription card;

  int page = 0;
  ProgressDialog _pr;
  List<Result> cardResult = [];
  String error = "";

  bool isLoaded = false;
  bool isError = false;
  @override
  void initState() {
    _pr = ProgressDialog(context, type: ProgressDialogType.Normal);
//    var myDate =
//        DateTime.fromMillisecondsSinceEpoch(int.parse("1600200142439"));
//    myDate.subtract(Duration(
//      hours: 24,
//    ));
//
//    final difference = oldDate.difference(currentDate).inHours;
//
//    var jiffy2 = Jiffy(oldDate)..add(hours: 24);
//
//    print(" oldDate ${oldDate.toString()}  ");
//    print(" difference ${difference}  jiffy2 ${jiffy2.fromNow()} ");

    _bloc = VcardBloc();
    stream();
    _bloc.featchAllCard();

    super.initState();
  }

  String _setTime(String time) {
    print(time);
    final oldDate = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    // var newTime = DateTime.parse(time);

    var jiffy2 = Jiffy(oldDate)..add(hours: 24);
    print(jiffy2.fromNow());
    return jiffy2.fromNow().replaceAll("ago", "").replaceAll("in", "");
//    setState(() {
//      time = jiffy2.fromNow();
//    });
    //  print(" difference jiffy2 ${jiffy2.fromNow()} ");
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
    setState(() {
      time = _setTime(cardResult[page].createdAt);
      print("time $time");
    });
  }

  stream() {
    card = _bloc.allVcards.listen(
      (event) {
        print("vcardModel  event $cardResult");
        setState(() {
          cardResult = event;
          if (cardResult.length > 0) time = _setTime(cardResult[0].createdAt);
          isLoaded = true;
        });
        print("vcardModel $cardResult");
      },
      onError: (err) {
        setState(() {
          error = err.toString();
          isError = true;
          isLoaded = true;
        });
        print("subscription err ${err.toString()}");
      },
      onDone: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoaded
          ? isError
              ? Center(child: Text(error))
              : cardResult.length > 0
                  ? _body()
                  : Center(
                      child:
                          Text("Virtual cards you've created will appear here"),
                    )
          : Center(child: CircularProgressIndicator()),
    );
  }

  _body() {
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
                  icon: Icon(Icons.keyboard_backspace, color: Colors.black),
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
                    return ['Delete this card'].map((String title) {
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
            "Valid for $time",
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
              itemCount: cardResult.length,
              itemBuilder: (BuildContext ctx, int index) {
                return _cardView(cardResult[index]);
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
      Clipboard.setData(new ClipboardData(text: _bloc.vCard[page].cardNo))
          .then((_) {
        showToastMsg("Card number copied to clipboard");
      });

      // showToastMsg(_bloc.vCard[page].toString());
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
      amount:
          "  ${data.currency == "NGN" ? "₦" : "\$"} ${formatNumberValue(double.parse(data.amount))}",
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
