import 'package:flutter/material.dart';
import 'package:slashit/src/resources/colors.dart';
import 'package:slashit/src/resources/text_styles.dart';
import 'package:slashit/src/view/business/barcodeScan.dart';

class RequestMoney extends StatefulWidget {
  static const routeName = "/request_money";
  @override
  _RequestMoneyState createState() => _RequestMoneyState();
}

class _RequestMoneyState extends State<RequestMoney> {
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
          _inputFields("Title"),
          SizedBox(height: 16),
          _inputFields("Description"),
          SizedBox(height: 16),
          _inputFields("Customer"),
          SizedBox(height: 16),
          _inputFields("Amount"),
          SizedBox(height: 16),
          _inputFields("Note"),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  _inputFields(String name) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: TextField(
        controller: null,
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
        onPressed: () =>
            Navigator.pushNamed(context, BarCodeScanning.routeName),
        child: Text('   Create  ', style: SignInStyle),
        color: Colors.blue,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)));
  }
}
