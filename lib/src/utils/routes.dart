import 'package:flutter/material.dart';
import 'package:slashit/src/view/auth/login_business.dart';
import 'package:slashit/src/view/auth/login_shopper.dart';
import 'package:slashit/src/view/home.dart';
import 'package:slashit/src/view/splash.dart';

class Routes {
  static const HOME = Home.routeName;
  static const root = Splash.routeName;
  static const LOGINSHOPPER = LoginShopper.routeName;
  static const LOGINBUSINESS = LoginBusiness.routeName;
  final route = <String, WidgetBuilder>{
    Routes.HOME: (context) => Home(),
    Routes.root: (context) => Splash(),
    Routes.LOGINSHOPPER: (context) => LoginShopper(),
    Routes.LOGINBUSINESS: (context) => LoginBusiness(),
  };
}
