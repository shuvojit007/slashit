import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:slashit/src/resources/colors.dart';
import 'package:slashit/src/resources/text_styles.dart';
import 'package:slashit/src/view/auth/login_shopper.dart';

class RegisterUser extends StatefulWidget {
  static const routeName = "/register";
  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
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
          SizedBox(height: 40),
          Padding(
              padding: EdgeInsets.only(top: 10, left: 10),
              child: IconButton(
                  icon: Icon(Icons.keyboard_backspace, color: PrimrayColor),
                  onPressed: () => Navigator.pop(context))),
          SizedBox(height: 20),
          Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Create Account", style: createAccount),
            ],
          )),
          SizedBox(height: 30),
          _userName(),
          SizedBox(height: 30),
          _userEmail(),
          SizedBox(height: 16),
          _userPass(),
          SizedBox(height: 20),
           _userConfirmPass(),
          SizedBox(height: 20),
          _signInButton(),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
            child: Divider(color: Colors.black26),
          ),
          Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Already have an account ? Sign in ", style: goToSignUp),
              GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, LoginShopper.routeName),
                child: Text("here", style: goToSignUpBlue),
              )
            ],
          )),
        ],
      ),
    );
  }

_userName() {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: TextField(
        controller: _emailController,
        decoration: InputDecoration(
          labelText: "Name",
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
  _userConfirmPass() {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: TextField(
        controller: _emailController,
        decoration: InputDecoration(
          labelText: "Confirm Password",
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
          child: Text('Register', style: SignInStyle),
          color: PrimrayColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0))),
    ));
  }

  void _onFormSubmitted() {}
}
