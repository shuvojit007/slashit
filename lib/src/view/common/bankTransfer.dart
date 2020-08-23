import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:slashit/src/models/bank.dart';
import 'package:slashit/src/repository/user_repository.dart';
import 'package:slashit/src/resources/colors.dart';
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

  @override
  void initState() {
    _networkCall();
    super.initState();
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
        title: Text("Bank Transfer"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
            ),
            child: TextField(
              controller: _accountNumber,
              decoration: InputDecoration(
                labelText: "Account Number",
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: PrimrayColor, width: 2.0),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
                prefixIcon: Icon(FontAwesomeIcons.moneyCheck),
              ),
              cursorColor: appbartitle,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
            ),
            child: TypeAheadField(
              textFieldConfiguration: TextFieldConfiguration(
                autofocus: false,
                controller: _bankController,
                enabled: textfieldStatus,
                decoration: InputDecoration(
                  labelText: "Bank Name ",
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: PrimrayColor, width: 2.0),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                  prefixIcon: Icon(Icons.account_balance),
                ),
              ),
              suggestionsCallback: (pattern) async {
                return list.where((value) =>
                    value.name.toLowerCase().contains(pattern.toLowerCase()));
              },
              itemBuilder: (context, suggestion) {
                return ListTile(
                  leading: Icon(Icons.account_balance),
                  title: Text(suggestion.name),
                  subtitle: Text("code : ${suggestion.code}"),
                );
              },
              onSuggestionSelected: (suggestion) {
                bankDetails = suggestion;
                _bankController.text = suggestion.name;
                _bankController.notifyListeners();
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
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
                  borderSide: BorderSide(color: PrimrayColor, width: 2.0),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
                prefixIcon: Icon(FontAwesomeIcons.moneyBill),
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
            color: Colors.blue,
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
