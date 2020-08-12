import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:slashit/src/repository/user_repository.dart';
import 'package:slashit/src/resources/colors.dart';
import 'package:slashit/src/resources/text_styles.dart';
import 'package:slashit/src/utils/showToast.dart';
import 'package:slashit/src/utils/validators.dart';
import 'package:slashit/src/view/auth/login_shopper.dart';

class RegisterUser extends StatefulWidget {
  static const routeName = "/register";
  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _lnameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  ProgressDialog _pr;

  //state value initilize
  bool _isDisabled;
  bool _showPassword;
  bool _showConfirmPassword;

  @override
  void initState() {
    _pr = ProgressDialog(context, type: ProgressDialogType.Normal);
    // TODO: implement initState
    super.initState();
    _isDisabled = true;
    _showPassword = true;
    _showConfirmPassword = true;
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
                "Create Account",
                style: loginTitle,
              ),
            ),
            SizedBox(height: 30),
            _fristName(),
            SizedBox(height: 30),
            _lastName(),
            SizedBox(height: 30),
            _userEmail(),
            SizedBox(height: 30),
            _userPass(),
            SizedBox(height: 30),
            _userConfirmPass(),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Wrap(
                children: <Widget>[
                  Text("By signing up you agree to Slashit ",
                      style: termsAndCondition),
                  GestureDetector(
                    onTap: () => {},
                    // Navigator.pushNamed(context, LoginShopper.routeName),
                    child: Text("Terms of Service", style: goToSignUpBlue),
                  ),
                  Text(" and ", style: termsAndCondition),
                  GestureDetector(
                    onTap: () => {},
                    // Navigator.pushNamed(context, LoginShopper.routeName),
                    child: Text("Privacy Policy", style: goToSignUpBlue),
                  )
                ],
              ),
            ),
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
      ),
    );
  }

  _fristName() {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: TextField(
        controller: _fnameController,
        decoration: InputDecoration(
          labelText: "First Name",
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: PrimrayColor, width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2.0),
          ),
          prefixIcon: Icon(Icons.supervised_user_circle),
        ),
        cursorColor: appbartitle,
      ),
    );
  }

  _lastName() {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: TextField(
        controller: _lnameController,
        decoration: InputDecoration(
          labelText: "Last Name",
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: PrimrayColor, width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2.0),
          ),
          prefixIcon: Icon(Icons.supervised_user_circle),
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
          prefixIcon: Icon(Icons.lock_outline),
          suffixIcon: IconButton(
              icon: Icon(
                _showPassword ? Icons.remove_red_eye : Icons.visibility_off,
                color: _showPassword ? Colors.blue : Colors.grey,
              ),
              onPressed: () {
                setState(() => _showPassword = !_showPassword);
              }),
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
        controller: _confirmPasswordController,
        obscureText: _showConfirmPassword,
        decoration: InputDecoration(
          labelText: "Confirm Password",
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: PrimrayColor, width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2.0),
          ),
          prefixIcon: Icon(Icons.lock_outline),
          suffixIcon: IconButton(
              icon: Icon(
                _showConfirmPassword
                    ? Icons.remove_red_eye
                    : Icons.visibility_off,
                color: _showConfirmPassword ? Colors.blue : Colors.grey,
              ),
              onPressed: () {
                setState(() => _showConfirmPassword = !_showConfirmPassword);
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
          child: Text('Register', style: SignInStyle),
          color: PrimrayColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0))),
    ));
  }

  handleInput() async {
    if (_fnameController.text.isNotEmpty &&
        _lnameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty) {
      if (!Validators.isValidEmail(_emailController.text)) {
        showToastMsgTop("Please add valid email");
        return;
      }

      if (!Validators.isValidPassword(_passwordController.text)) {
        showToastMsgTop("Please add valid password");
        return;
      }

      if (_passwordController.text != _confirmPasswordController.text) {
        showToastMsgTop("Passowd not matched");
        return;
      }

      FocusScope.of(context).requestFocus(FocusNode());
      _pr.show();

      var userInput = {
        "firstname": "\"${_fnameController.text}\"",
        "lastname": "\"${_lnameController.text}\"",
        "email": "\"${_emailController.text}\"",
        "password": "\"${_passwordController.text}\"",
        "role": "shopper"
      };

      await UserRepository.instance.registerUser(userInput);
      _pr.hide();
    } else {
      showToastMsgTop("Please add fill up all the input");
    }
  }
}
