import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:slashit/src/database/dao.dart';
import 'package:slashit/src/di/locator.dart';
import 'package:slashit/src/models/serviceFee.dart';
import 'package:slashit/src/repository/user_repository.dart';
import 'package:slashit/src/resources/colors.dart';
import 'package:slashit/src/resources/text_styles.dart';
import 'package:slashit/src/utils/number.dart';
import 'package:slashit/src/utils/prefmanager.dart';
import 'package:slashit/src/utils/showToast.dart';
import 'package:slashit/src/view/shopper/virtual_card/billingAddress.dart';
import 'package:slashit/src/view/shopper/virtual_card/createVCard.dart';

class addVCardDetails extends StatefulWidget {
  @override
  _addVCardDetailsState createState() => _addVCardDetailsState();
}

class _addVCardDetailsState extends State<addVCardDetails> {
  String _dropDownValue = "";
  TextEditingController _controller = TextEditingController();
  num amount = 0;
  num value = 0;
  num percent = 0;

  int servicecharge = 0;
  int serviceChargeFlat = 0;

  String chargeStatus = "";
  int pos = 0;
  List<ServiceFee> service = [];

  num spendLimit = 0;

  ProgressDialog _pr;

  @override
  void initState() {
//    _controller.addListener(() {
//      print("   controller ${_controller.text}");
//      value = int.parse(_controller.text);
//      _updateTheValue();
//    });

    _pr = ProgressDialog(context, type: ProgressDialogType.Normal);
    _getService();
    super.initState();
  }

  _updateTheValue() {
    if (servicecharge != 0 && servicecharge != null) {
      percent = value * servicecharge * .01;
    }

    if (serviceChargeFlat != 0 && serviceChargeFlat != null) {
      percent = serviceChargeFlat;
    }

    amount = value + percent;
    print("amount ${amount}  percent ${percent}  value ${value}");
  }

  _changeDropDownValue(ServiceFee fee) {
    setState(
      () {
        _dropDownValue = fee.symbol;
        servicecharge = fee?.serviceChargePercentage;
        serviceChargeFlat = fee?.serviceChargeFlat;

        if (fee.currency == "USD") {
          spendLimit = locator<PrefManager>().spendLimit /
              locator<PrefManager>().exchangeRate;
        } else {
          spendLimit = locator<PrefManager>().spendLimit;
        }
        _updateTheValue();
      },
    );
  }

  _getService() async {
    _pr.show();
    await UserRepository.instance.fetchSettings();
    _pr.hide();
    service = await dbLogic.getService();

    if (service.length > 0) {
      _changeDropDownValue(service[0]);
    }
  }

  textChangeListener(String text) async {
    print("   controller ${_controller.text}");
    value = double.parse(text);
    setState(() {
      _updateTheValue();
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
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
                padding: EdgeInsets.only(left: 20, bottom: 10),
                child: Text(
                  "How much do you plan on spending?",
                  style: createVcard1,
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 10),
                  child: Text(
                    "Spend limit ($_dropDownValue ${formatNumberValue(spendLimit)})",
                    style: createVcard2,
                  )),
              Container(
                margin: EdgeInsets.only(
                  top: 80,
                ),
                width: double.infinity,
                height: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 30,
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              hint: Text(
                                _dropDownValue,
                                style: createVcard4,
                              ),
                              style: createVcard4,
                              items: service.map(
                                (val) {
                                  return DropdownMenuItem<ServiceFee>(
                                    value: val,
                                    child: Text(val.symbol),
                                  );
                                },
                              ).toList(),
                              onChanged: _changeDropDownValue,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                              height: 50,
                              child: TextField(
                                controller: _controller,
                                onChanged: textChangeListener,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                  decimal: true,
                                ),
                                decoration: InputDecoration.collapsed(
                                    hintText: "0.00", border: InputBorder.none),
                                textAlign: TextAlign.center,
                              )),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: <Widget>[
                            if (serviceChargeFlat != null &&
                                serviceChargeFlat != 0) ...[
                              Text(
                                "+$serviceChargeFlat Service fee",
                                style: createVcard3,
                              ),
                            ],
                            if (servicecharge != null &&
                                servicecharge != 0) ...[
                              Text(
                                "+$servicecharge% Service fee",
                                style: createVcard3,
                              ),
                            ],
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                    Container(
                      child: Divider(color: Colors.black26),
                    ),
                    GestureDetector(
                      onTap: _goToBillindAddress,
                      child: Container(
                        color: Colors.grey[100],
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.only(
                            top: 10, left: 10, bottom: 10, right: 10),
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
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 50,
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child: RaisedButton(
                textColor: Colors.white,
                //shape: StadiumBorder(),
                color: PrimaryColor,
                onPressed: _goToCreateVCard,
                child: Text(
                    "Total Amount $_dropDownValue ${amount.toStringAsFixed(2)}"),
              ),
            ),
          )
        ],
      ),
    );
  }

  _goToBillindAddress() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => BillingAddress()));
  }

  _goToCreateVCard() {
    if (amount <= 0) {
      showToastMsg("please add amount first");
      return;
    }

    if (spendLimit < amount) {
      showToastMsg("input amount is bigger than spend limit");
      return;
    }

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CreateVCard(value, percent, _dropDownValue)));
  }
}
