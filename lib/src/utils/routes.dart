import 'package:flutter/material.dart';
import 'package:slashit/src/view/auth/login_business.dart';
import 'package:slashit/src/view/auth/login_shopper.dart';
import 'package:slashit/src/view/auth/register_user.dart';
import 'package:slashit/src/view/home.dart';
import 'package:slashit/src/view/pages/create_payment.dart';
import 'package:slashit/src/view/shopper/debitCards.dart';
import 'package:slashit/src/view/shopper/featuresList.dart';
import 'package:slashit/src/view/shopper/wallet.dart';
import 'package:slashit/src/view/splash.dart';
import 'package:slashit/src/widget/paystack.dart';

class Routes {
  static const HOME = Home.routeName;
  static const DEBITCARDS = DebitCards.routeName;
  static const root = Splash.routeName;
  static const PAYSTACK = PayStackWidget.routeName;
  static const FEATURES = FeaturesList.routeName;
  static const WALLET = WalletScreen.routeName;
  static const LOGINSHOPPER = LoginShopper.routeName;
  static const LOGINBUSINESS = LoginBusiness.routeName;
  static const REGISTERUSER = RegisterUser.routeName;
  static const CREATEPAYMENTS = CreatePayemts.routeName;
  final route = <String, WidgetBuilder>{
    Routes.HOME: (context) => Home(),
    Routes.root: (context) => Splash(),
    Routes.LOGINSHOPPER: (context) => LoginShopper(),
    Routes.DEBITCARDS: (context) => DebitCards(),
    Routes.FEATURES: (context) => FeaturesList(),
    Routes.WALLET: (context) => WalletScreen(),
    Routes.PAYSTACK: (context) => PayStackWidget(),
    Routes.LOGINBUSINESS: (context) => LoginBusiness(),
    Routes.REGISTERUSER: (context) => RegisterUser(),
    Routes.CREATEPAYMENTS: (context) => CreatePayemts(),
  };
}
