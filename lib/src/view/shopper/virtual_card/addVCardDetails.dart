import 'package:flutter/material.dart';
import 'package:slashit/src/database/dao.dart';
import 'package:slashit/src/di/locator.dart';
import 'package:slashit/src/models/serviceFee.dart';
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
  String _dropDownValue = "₦";
  TextEditingController _controller = TextEditingController();
  int amount = 0;
  int value = 0;
  int percent = 0;
  ServiceFee dollar, ngn;
  int servicecharge = 0;
  int serviceChargeFlat = 0;

  String chargeStatus = "";

  @override
  void initState() {
    _controller.addListener(() {
      value = int.parse(_controller.text);
      _updateTheValue();
    });
    _getService();

    super.initState();
  }

  _updateTheValue() {
    if (servicecharge != 0 && servicecharge != null) {
      percent = (value * servicecharge * .01).round();
    }

    if (serviceChargeFlat != 0 && serviceChargeFlat != null) {
      percent = serviceChargeFlat;
    }
    print(
        "serviceCharge $servicecharge  serviceChargeFlat $serviceChargeFlat  percent $percent");
    setState(() {
      amount = value + percent;
    });
  }

  _changeDropDownValue(val) {
    print("val $val");
    setState(
      () {
        _dropDownValue = val;
        if (_dropDownValue == "\$") {
          servicecharge = dollar?.serviceChargePercentage;
          serviceChargeFlat = dollar?.serviceChargeFlat;
        } else if (_dropDownValue == "₦") {
          servicecharge = ngn?.serviceChargePercentage;
          serviceChargeFlat = ngn?.serviceChargeFlat;
        }
        _updateTheValue();
      },
    );
  }

  _getService() async {
    List<ServiceFee> serviceFee = await dbLogic.getService();
    serviceFee.forEach((element) {
      if (element.currency == "\$") dollar = element;
      if (element.currency == "₦") ngn = element;
    });
    _changeDropDownValue("₦");
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
              SizedBox(height: 10),
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
                    "Spend limit (₦ ${formatNumberValue(locator<PrefManager>().spendLimit)})",
                    style: createVcard2,
                  )),
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
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
                            items: ['₦', '\$'].map(
                              (val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Text(val),
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
                          if (servicecharge != null && servicecharge != 0) ...[
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
                    "Total Amount $_dropDownValue ${formatNumberValue(amount)}"),
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

    if (locator<PrefManager>().spendLimit < amount) {
      showToastMsg("input amount is bigger than spend limit");
      return;
    }

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CreateVCard(value, percent, _dropDownValue)));
  }
}
