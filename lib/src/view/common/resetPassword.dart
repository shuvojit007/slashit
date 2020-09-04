import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:slashit/src/repository/user_repository.dart';
import 'package:slashit/src/resources/colors.dart';
import 'package:slashit/src/utils/NetworkCheck.dart';
import 'package:slashit/src/utils/showToast.dart';

class ResetPassword extends StatefulWidget {
  static const routeName = "/resetpass";
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController _emailController = TextEditingController();
  ProgressDialog _pr;
  bool _showPassword;
  @override
  void initState() {
    _pr = ProgressDialog(context, type: ProgressDialogType.Normal);
    _showPassword = true;
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text("Reset your password", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 30),
          _userEmail(),
          SizedBox(height: 20),
          RaisedButton(
              textColor: Colors.white,
              shape: StadiumBorder(),
              color: PrimaryColor,
              onPressed: _resetPass,
              child: Text("SUBMIT"))
        ],
      ),
    );
  }

  _userEmail() {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: TextField(
        controller: _emailController,
        decoration: InputDecoration(
          labelText: "Email",
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: PrimaryColor, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
          ),
          //    prefixIcon: Icon(Icons.mail_outline),
        ),
        cursorColor: appbartitle,
      ),
    );
  }

  _resetPass() async {
    bool internet = await NetworkCheck().check();
    if (internet != null && internet) {
      if (_emailController.text.isEmpty ||
          !validateEmail(_emailController.text)) {
        showToastMsg("Please add valid email address");
      } else {
        _pr.show();
        await UserRepository.instance.forgetPass(_emailController.text);
        _pr.hide();
        Navigator.pop(context);
      }
    } else {
      showToastMsg("No Internet Connection");
    }

    FocusScope.of(context).requestFocus(FocusNode());
  }

  bool validateEmail(String value) {
    print(value);
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return false;
    else
      return true;
  }
}
