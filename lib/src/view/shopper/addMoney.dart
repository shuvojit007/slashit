import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:slashit/src/blocs/wallet/wallet_bloc.dart';
import 'package:slashit/src/blocs/wallet/wallet_bloc_event.dart';
import 'package:slashit/src/repository/user_repository.dart';
import 'package:slashit/src/resources/text_styles.dart';
import 'package:slashit/src/utils/showToast.dart';
import 'package:slashit/src/view/shopper/shopper.dart' as SHOPPER;

class AddMoney extends StatefulWidget {
  static const routeName = "/addMoney";
  @override
  _AddMoneyState createState() => _AddMoneyState();
}

class _AddMoneyState extends State<AddMoney> {
  TextEditingController _controller = TextEditingController();

  ProgressDialog _pr;
  @override
  void initState() {
    _pr = ProgressDialog(context, type: ProgressDialogType.Normal);

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _header(),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 200,
                child: TextField(
                  autofocus: true,
                  controller: _controller,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.numberWithOptions(
                    decimal: true,
                  ),
//                  inputFormatters: <TextInputFormatter>[
//                    WhitelistingTextInputFormatter.digitsOnly
//                  ],
                  decoration: InputDecoration.collapsed(
                      hintText: "0.00", border: InputBorder.none),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              RaisedButton(
                onPressed: addMoney,
                color: Colors.blue,
                shape: StadiumBorder(),
                child: Text(
                  "Add Money",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _header() {
    return PreferredSize(
      preferredSize: Size.fromHeight(100),
      child: Container(
        height: 100,
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 20, top: 50),
                  child: Text("Cancel", style: debitCards),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  addMoney() async {
    if (_controller.text.isEmpty) {
      showToastMsgTop("Please add valid input");
      return;
    }

    if (!RegExp(r'[+-]?([0-9]*[.])?[0-9]+').hasMatch(_controller.text)) {
      showToastMsgTop("Please add valid input");
      return;
    }
    FocusScope.of(context).unfocus();
    _pr.show();
    bool result =
        await UserRepository.instance.addMony(double.parse(_controller.text));
    if (result) {
      await UserRepository.instance.fetchUser();
      BlocProvider.of<WalletBloc>(context).add(GetWallet());
      _pr.hide();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => SHOPPER.Shopper(),
          ),
          ModalRoute.withName('/shopper'));
    } else {
      _pr.hide();
    }
  }
}
