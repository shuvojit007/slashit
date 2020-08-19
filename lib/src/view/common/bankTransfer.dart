import 'package:flutter/material.dart';
import 'package:slashit/src/resources/colors.dart';

class BankTransfer extends StatefulWidget {
  static const routeName = "/bank";
  @override
  _BankTransferState createState() => _BankTransferState();
}

class _BankTransferState extends State<BankTransfer> {
  final TextEditingController _accountNumber = TextEditingController();
  final TextEditingController _bankController = TextEditingController();

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
                prefixIcon: Icon(Icons.account_balance_wallet),
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
            child: TextField(
              controller: _bankController,
              decoration: InputDecoration(
                labelText: "Bank",
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: PrimrayColor, width: 2.0),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
                prefixIcon: const Icon(Icons.account_balance),
              ),
              cursorColor: appbartitle,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          RaisedButton(
            shape: StadiumBorder(),
            onPressed: () {},
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
}
