import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:slashit/src/resources/colors.dart';
import 'package:slashit/src/resources/text_styles.dart';

class LoginShopper extends StatefulWidget {
  static const routeName = "/login_shopper";
  @override
  _LoginShopperState createState() => _LoginShopperState();
}

class _LoginShopperState extends State<LoginShopper> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  ProgressDialog _pr;

  @override
  void initState() {
    _pr = ProgressDialog(context, type: ProgressDialogType.Normal);
    // TODO: implement initState
    super.initState();
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
          SizedBox(height: 100),
          Padding(
            padding: EdgeInsets.only(left: 20, bottom: 10),
            child: Text(
              "Login",
              style: loginTitle,
            ),
          ),
          SizedBox(height: 30),
          _userEmail(),
          SizedBox(height: 16),
          _userPass(),
          SizedBox(height: 24),
          GestureDetector(
            onTap: () => {},
            child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text("Forget Password ?", style: forgotPass)),
          ),
          SizedBox(height: 20),
          _signInButton(),
          SizedBox(height: 24),
          GestureDetector(
            onTap: () => {},
            child: Center(child: Text("Sign Up", style: SignupStyle)),
          ),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
            child: Divider(color: Colors.black26),
          ),
          Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Business account ? Sign in ", style: goToSignUp),
              Text("here", style: goToSignUpBlue)
            ],
          )),
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
        obscureText: true,
        decoration: InputDecoration(
          labelText: "Password",
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

  _signInButton() {
    return Center(
        child: Container(
      width: 290,
      height: 45.0,
      child: RaisedButton(
          onPressed: _onFormSubmitted,
          child: Text('Sign In', style: SignInStyle),
          color: PrimrayColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0))),
    ));
  }

  void _onFormSubmitted() {}
}
