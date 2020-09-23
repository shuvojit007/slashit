import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:slashit/src/database/dao.dart';
import 'package:slashit/src/repository/user_repository.dart';
import 'package:slashit/src/resources/colors.dart';
import 'package:slashit/src/resources/text_styles.dart';
import 'package:slashit/src/utils/showToast.dart';
import 'package:slashit/src/utils/validators.dart';
import 'package:slashit/src/view/auth/login_business.dart';
import 'package:slashit/src/view/auth/register_user.dart';
import 'package:slashit/src/view/common/resetPassword.dart';
import 'package:slashit/src/view/home.dart';

class LoginShopper extends StatefulWidget {
  static const routeName = "/login_shopper";
  @override
  _LoginShopperState createState() => _LoginShopperState();
}

class _LoginShopperState extends State<LoginShopper> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 70),
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
              onTap: () =>
                  Navigator.pushNamed(context, ResetPassword.routeName),
              child: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text("Forgot Password ?", style: forgotPass)),
            ),
            SizedBox(height: 20),
            _signInButton(),
            SizedBox(height: 24),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, RegisterUser.routeName),
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
                GestureDetector(
                  onTap: () =>
                      Navigator.pushNamed(context, LoginBusiness.routeName),
                  child: Text("here", style: goToSignUpBlue),
                )
              ],
            )),
          ],
        ),
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
            borderSide: BorderSide(color: PrimaryColor, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
          ),
          //  prefixIcon: Icon(Icons.lock_outline),
          suffixIcon: IconButton(
              icon: Icon(
                _showPassword ? Icons.remove_red_eye : Icons.visibility_off,
                color: _showPassword ? PrimaryColor : Colors.grey,
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
          color: PrimaryColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0))),
    ));
  }

  handleInput() async {
    if (Validators.isValidEmail(_emailController.text) &&
        Validators.isValidPassword(_passwordController.text)) {
      FocusScope.of(context).requestFocus(FocusNode());
      _pr.show();
      await dbLogic.deleteAll();
      bool result = await UserRepository.instance
          .authUser(_emailController.text, _passwordController.text, false);

      bool settingsResult = await UserRepository.instance.fetchSettings();
      _pr.hide();
      if (result) {
        Navigator.pushNamedAndRemoveUntil(
            context, Home.routeName, (route) => false);
      }
    } else {
      showToastMsg("Add valid input");
    }
  }

//  _passwordReset() {
//    showDialog(
//        context: context, builder: (BuildContext context) => ResetPassword());
//  }
}
