import 'package:flutter/material.dart';
import 'package:slashit/src/resources/colors.dart';
import 'package:slashit/src/resources/text_styles.dart';
import 'package:slashit/src/utils/showToast.dart';

import 'barcodeScan.dart';

class RequestMoney extends StatefulWidget {
  static const routeName = "/request_money";
  @override
  _RequestMoneyState createState() => _RequestMoneyState();
}

class _RequestMoneyState extends State<RequestMoney> {
  TextEditingController _title = TextEditingController();
  TextEditingController _desc = TextEditingController();
  TextEditingController _amount = TextEditingController();
  TextEditingController _note = TextEditingController();

  @override
  void dispose() {
    _title?.dispose();
    _desc?.dispose();
    _amount?.dispose();
    _note?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Payments"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[body(), _actionBtn()],
        ),
      ),
    );
  }

  body() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 15, right: 15, top: 20),
      child: Column(
        children: <Widget>[
          SizedBox(height: 16),
          _inputFields("Title", _title),
          SizedBox(height: 16),
          _inputFields("Description", _desc),
          SizedBox(height: 16),
          _inputFields("Amount", _amount),
          SizedBox(height: 16),
          _inputFields("Note", _note),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  _inputFields(String name, TextEditingController _con) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: TextField(
        controller: _con,
        decoration: InputDecoration(
          labelText: name,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: PrimrayColor, width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2.0),
          ),
        ),
        cursorColor: appbartitle,
      ),
    );
  }

  _actionBtn() {
    return RaisedButton(
        onPressed: () => _createPaymentReq(),
        child: Text('   Create  ', style: SignInStyle),
        color: Colors.blue,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)));
  }

  _createPaymentReq() {
    if (_title.text.isNotEmpty &&
        _note.text.isNotEmpty &&
        _desc.text.isNotEmpty &&
        _amount.text.isNotEmpty) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BarCodeScanning(
                    title: _title.text,
                    note: _note.text,
                    desc: _desc.text,
                    amount: int.parse(_amount.text),
                  )));
    } else {
      showToastMsg("Please fill up the form");
    }
  }
}
