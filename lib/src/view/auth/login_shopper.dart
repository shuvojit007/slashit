import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:slashit/src/resources/colors.dart';
import 'package:slashit/src/resources/text_styles.dart';
import 'package:slashit/src/service/graph_api.dart';
import 'package:slashit/src/view/auth/login_business.dart';
import 'package:slashit/src/view/auth/register_user.dart';
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
          onPressed: () => Navigator.pushNamed(context, Home.routeName),
          child: Text('Sign In', style: SignInStyle),
          color: PrimrayColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0))),
    ));
  }

  _onFormSubmitted() {
    return Mutation(
      options: MutationOptions(
        documentNode:
            gql(GraphApi.login), // this is the mutation string you just created
        // you can update the cache based on results
        update: (Cache cache, QueryResult result) {
          return cache;
        },
        // or do something with the result.data on completion
        onCompleted: (dynamic resultData) {
          LazyCacheMap map = resultData.get("Login");
          map.forEach((key, value) {
            print("key $key  value $value");
          });
        },
      ),
      builder: (
        RunMutation runMutation,
        QueryResult result,
      ) {
        return Center(
            child: Container(
          width: 290,
          height: 45.0,
          child: RaisedButton(
              onPressed: () => runMutation({
                    'email': "shuvojitkar241@gmail.com",
                    'password': "123456798"
                  }),
              child: Text('Sign In', style: SignInStyle),
              color: PrimrayColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0))),
        ));
      },
    );
  }
}
