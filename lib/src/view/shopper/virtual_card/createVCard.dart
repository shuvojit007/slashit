import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:slashit/src/repository/user_repository.dart';
import 'package:slashit/src/resources/colors.dart';
import 'package:slashit/src/resources/str.dart';
import 'package:slashit/src/resources/text_styles.dart';
import 'package:slashit/src/utils/number.dart';
import 'package:slashit/src/utils/showToast.dart';
import 'package:slashit/src/view/shopper/virtual_card/vcard.dart';
import 'package:slashit/src/view/shopper/virtual_card/websiteDetails.dart';

class CreateVCard extends StatefulWidget {
  int amount;
  int charge;
  String currancyType;

  CreateVCard(this.amount, this.charge, this.currancyType);

  @override
  _CreateVCardState createState() => _CreateVCardState();
}

class _CreateVCardState extends State<CreateVCard> {
  Key radio1, radio2, radio3, radio4;

  int totalAmount = 0;
  int _radioValue1 = -1;
  _handleRadioValueChange(int value) {
    setState(() {
      _radioValue1 = _radioValue1 == 0 ? -1 : 0;
    });
  }

  ProgressDialog _pr;
  @override
  void initState() {
    _pr = ProgressDialog(context, type: ProgressDialogType.Normal);
    totalAmount = widget.amount + widget.charge;

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 40),
              Padding(
                  padding: EdgeInsets.only(top: 10, left: 10),
                  child: IconButton(
                      icon: Icon(Icons.keyboard_backspace, color: Colors.black),
                      onPressed: () => Navigator.pop(context))),
              SizedBox(height: 5),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 10, bottom: 10),
                child: Text(
                  "Pay 25% of the total amount you plan on spending and pay the rest over six weeks",
                  style: createVcard1,
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  child: Text(
                    Str.createvCardSlug,
                    style: createVcard6,
                  )),
              for (int i = 0; i < 4; i++) _transactions(i),
              SizedBox(height: 200),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 100,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    child: Row(
                      children: <Widget>[
                        Radio(
                          value: 0,
                          key: radio3,
                          groupValue: _radioValue1,
                          onChanged: _handleRadioValueChange,
                        ),
                        Expanded(
                          child: Text(
                            Str.createvCardSlug2,
                            style: createVcard6,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: PrimaryColor,
                    onPressed: _goToVcard,
                    child: Text(
                      "Pay \nand create your ${widget.currancyType} ${formatNumberValue(totalAmount)} card",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }

  Widget _transactions(int i) {
    return Container(
      height: 65,
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (i == 0) ...[
            Radio(
              value: 1,
              key: radio3,
              groupValue: 1,
              onChanged: _handleRadioValueChange,
            ),
          ] else ...[
            SizedBox(
              width: 50,
            )
          ],
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                    "${widget.currancyType} ${formatNumberValue(totalAmount / 4)}",
                    style: Repayments1),
                SizedBox(
                  height: 5,
                ),
                Text(
                  getDate(i),
                  style: Repayments2,
                )
              ],
            ),
          ),
          SizedBox(
            width: 50,
          )
        ],
      ),
    );
  }

  String getDate(int i) {
    switch (i) {
      case 0:
        return "Due Today";
      case 1:
        return "Due 2 weeks later";
      case 2:
        return "Due 4 weeks later";
      case 3:
        return "Due 6 weeks later";
    }
  }

  _goToVcard() async {
    if (_radioValue1 != 0) {
      showToastMsg("Please accept the agrement");
      return;
    }

    _pr.show();
    bool result = await UserRepository.instance
        .addVcard(widget.currancyType == "\$" ? "USD" : "NGN", widget.amount);
    _pr.hide();

    if (result) {
      Navigator.pushNamedAndRemoveUntil(context, VCard.routeName,
          (Route route) => route.settings.name == WebsiteDetails.routeName);
      // Navigator.push(context, MaterialPageRoute(builder: (context) => VCard()));
    }
  }
}
