import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:slashit/src/repository/user_repository.dart';
import 'package:slashit/src/resources/colors.dart';
import 'package:slashit/src/resources/text_styles.dart';
import 'package:slashit/src/utils/showToast.dart';
import 'package:slashit/src/utils/validators.dart';
import 'package:slashit/src/widget/dialog/resetPass.dart';

import '../home.dart';

class LoginBusiness extends StatefulWidget {
  static const routeName = "/login_business";
  @override
  _LoginBusinessState createState() => _LoginBusinessState();
}

class _LoginBusinessState extends State<LoginBusiness> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  ProgressDialog _pr;
  bool _showPassword;
  @override
  void initState() {
    _pr = ProgressDialog(context, type: ProgressDialogType.Normal);
    // TODO: implement initState
    super.initState();
    _showPassword = true;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 40),
          Padding(
              padding: EdgeInsets.only(top: 10, left: 10),
              child: IconButton(
                  icon: Icon(Icons.keyboard_backspace, color: PrimrayColor),
                  onPressed: () => Navigator.pop(context))),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(left: 20, bottom: 10),
            child: Text(
              "Help your customer pay you easily",
              style: loginTitle,
            ),
          ),
          SizedBox(height: 30),
          _userEmail(),
          SizedBox(height: 16),
          _userPass(),
          SizedBox(height: 24),
          GestureDetector(
            onTap: _passwordReset,
            child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text("Forget Password ?", style: forgotPass)),
          ),
          SizedBox(height: 20),
          _signInButton(),
          SizedBox(height: 10),
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
            borderSide: BorderSide(color: PrimrayColor, width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2.0),
          ),
          prefixIcon: Icon(Icons.mail_outline),
        ),
        cursorColor: appbartitle,
      ),
    );
  }

  _userPass() {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: TextField(
        controller: _passwordController,
        obscureText: _showPassword,
        decoration: InputDecoration(
          labelText: "Password",
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: PrimrayColor, width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2.0),
          ),
          prefixIcon: Icon(Icons.lock_outline),
          suffixIcon: IconButton(
              icon: Icon(
                _showPassword ? Icons.remove_red_eye : Icons.visibility_off,
                color: _showPassword ? Colors.blue : Colors.grey,
              ),
              onPressed: () {
                setState(() => _showPassword = !_showPassword);
              }),
        ),
        cursorColor: appbartitle,
      ),
    );
  }

  _signInButton() {
    return Center(
        child: Container(
      width: 290,
      height: 45.0,
      child: RaisedButton(
          onPressed: handleInput,
          child: Text('Sign In', style: SignInStyle),
          color: PrimrayColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0))),
    ));
  }

  handleInput() async {
    if (Validators.isValidEmail(_emailController.text) &&
        Validators.isValidPassword(_passwordController.text)) {
      FocusScope.of(context).requestFocus(FocusNode());
      _pr.show();
      bool result = await UserRepository.instance
          .authUser(_emailController.text, _passwordController.text, true);
      _pr.hide();
      if (result) {
        Navigator.pushNamedAndRemoveUntil(
            context, Home.routeName, (route) => false);
      }
    } else {
      showToastMsg("Add valid input");
    }
  }

  _passwordReset() {
    showDialog(
        context: context, builder: (BuildContext context) => ResetPassword());
  }
}
