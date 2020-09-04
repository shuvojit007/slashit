import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:slashit/src/models/bank.dart';
import 'package:slashit/src/repository/user_repository.dart';
import 'package:slashit/src/resources/colors.dart';
import 'package:slashit/src/resources/text_styles.dart';
import 'package:slashit/src/services/network_request.dart';
import 'package:slashit/src/utils/showToast.dart';

class BankTransfer extends StatefulWidget {
  static const routeName = "/bank";
  @override
  _BankTransferState createState() => _BankTransferState();
}

class _BankTransferState extends State<BankTransfer> {
  final TextEditingController _accountNumber = TextEditingController();
  final TextEditingController _bankController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  ProgressDialog _pr;
  List<Datum> list;
  bool textfieldStatus = false;
  Datum bankDetails;
  final _debouncer = Debouncer(milliseconds: 500);

  String bankCode;
  String accountName;
  String accNumber;

  @override
  void initState() {
    _networkCall();
    super.initState();
  }

  onTextChange(String text) async {
    _debouncer.run(() async {
      print("text $text");
      if (_bankController.text.isNotEmpty &&
          _accountNumber.text.isNotEmpty &&
          _accountNumber.text.length > 8) {
        if (accNumber != _accountNumber.text) {
          accNumber = _accountNumber.text;
          String code = await UserRepository.instance
              .accountHolderName(bankDetails.code, _accountNumber.text);
          print("code $code");
          print("bank ${bankDetails.code}");
          if (code != null) {
            setState(() {
              accountName = code;
            });
          } else {
            setState(() {
              accountName = null;
            });
          }
        }
      }
    });
  }

  _networkCall() async {
    _pr = await ProgressDialog(context, type: ProgressDialogType.Normal);
    _pr.show();
    print("network call");
    String data = await Service.instance.getBankInformation();

    if (data.isEmpty) {
      _pr.hide();
      showToastMsg("Something went wrong");
      return;
    }
    BankList bankList = bankListFromMap(data.toString());
    if (bankList.data.length <= 0) {
      _pr.hide();
      showToastMsg("Something went wrong");
      return;
    }
    setState(() {
      list = bankList.data;
      textfieldStatus = true;
    });

    _pr.hide();
  }

  @override
  void dispose() {
    _accountNumber?.dispose();
    _bankController?.dispose();
    _amountController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bank Transfer", style: userTitle),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10),
            child: TypeAheadField(
              textFieldConfiguration: TextFieldConfiguration(
                autofocus: false,
                controller: _bankController,
                enabled: textfieldStatus,
                decoration: InputDecoration(
                  labelText: "Bank Name ",
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: PrimaryColor, width: 1.0),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                  // prefixIcon: Icon(Icons.account_balance),
                ),
              ),
              suggestionsCallback: (pattern) async {
                return list.where((value) =>
                    value.name.toLowerCase().contains(pattern.toLowerCase()));
              },
              itemBuilder: (context, suggestion) {
                return ListTile(
                    leading: Icon(Icons.account_balance),
                    title: Text(suggestion.name));
              },
              onSuggestionSelected: (suggestion) {
                bankDetails = suggestion;
                _bankController.text = suggestion.name;
                _bankController.notifyListeners();
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: TextField(
              onChanged: onTextChange,
              controller: _accountNumber,
              decoration: InputDecoration(
                labelText: "Account Number",
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: PrimaryColor, width: 1.0),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                ),
                //   prefixIcon: Icon(FontAwesomeIcons.moneyCheck),
              ),
              cursorColor: appbartitle,
            ),
          ),
          if (accountName != null) ...[
            Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 5,
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(accountName),
              ),
            )
          ],
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: TextField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ],
              controller: _amountController,
              decoration: InputDecoration(
                labelText: "Amount",
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: PrimaryColor, width: 1.0),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                ),
                //  prefixIcon: Icon(FontAwesomeIcons.moneyBill),
              ),
              cursorColor: appbartitle,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          RaisedButton(
            shape: StadiumBorder(),
            onPressed: _transferToBank,
            color: PrimaryColor,
            child: Text(
              "Make Transfer",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  _transferToBank() async {
    if (_accountNumber.text.isEmpty) {
      showToastMsg("Please add valid account number");
      return;
    }
    if (_bankController.text.isEmpty) {
      showToastMsg("Please add valid bank ");
      return;
    }

    if (bankDetails == null) {
      showToastMsg("Please add valid bank ");
      return;
    }

    if (_amountController.text.isEmpty) {
      showToastMsg("Please add valid amount ");
      return;
    }

    _pr?.show();
    await UserRepository.instance.withdrawBalance(
        int.parse(_amountController.text),
        _amountController.text,
        bankDetails.code);
    _pr?.hide();
  }
}

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});
  run(VoidCallback action) {
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
