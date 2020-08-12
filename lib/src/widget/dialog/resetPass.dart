import 'package:flutter/material.dart';
import 'package:slashit/src/repository/user_repository.dart';
import 'package:slashit/src/resources/colors.dart';
import 'package:slashit/src/resources/text_styles.dart';
import 'package:slashit/src/utils/NetworkCheck.dart';
import 'package:slashit/src/utils/showToast.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController _controller = TextEditingController();
  GlobalKey<_ResetPasswordState> _key = new GlobalKey();
  bool _validate = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 0.0,
        child: Container(
            padding: EdgeInsets.all(5.0),
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 20),
                    Text("Reset your password", style: rfrdailog),
                    SizedBox(height: 10),
                    TextFormField(
                        decoration: InputDecoration(
                            hintText: "Enter your email here",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: PrimrayColor))),
                        cursorColor: appbartitle,
                        controller: _controller,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done),
                    SizedBox(height: 5),
                    RaisedButton(
                        textColor: Colors.white,
                        shape: StadiumBorder(),
                        color: PrimrayColor,
                        onPressed: _resetPass,
                        child: Text("SUBMIT"))
                  ],
                ))));
  }

  _resetPass() async {
    bool internet = await NetworkCheck().check();
    if (internet != null && internet) {
      if (_controller.text.isEmpty || !validateEmail(_controller.text)) {
        showToastMsg("Please add valid email address");
      } else {
        await UserRepository.instance.forgetPass(_controller.text);
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
