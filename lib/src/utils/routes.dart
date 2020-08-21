import 'package:flutter/material.dart';
import 'package:slashit/src/view/auth/login_business.dart';
import 'package:slashit/src/view/auth/login_shopper.dart';
import 'package:slashit/src/view/auth/register_user.dart';
import 'package:slashit/src/view/business/barcodeScan.dart';
import 'package:slashit/src/view/business/requestDetails.dart';
import 'package:slashit/src/view/business/request_money.dart';
import 'package:slashit/src/view/business/requestsList.dart';
import 'package:slashit/src/view/common/bankTransfer.dart';
import 'package:slashit/src/view/common/transactions.dart';
import 'package:slashit/src/view/home.dart';
import 'package:slashit/src/view/shopper/addMoney.dart';
import 'package:slashit/src/view/shopper/debitCards.dart';
import 'package:slashit/src/view/shopper/featuresList.dart';
import 'package:slashit/src/view/shopper/orderInfo.dart';
import 'package:slashit/src/view/shopper/repayment.dart';
import 'package:slashit/src/view/shopper/shopper_requests.dart';
import 'package:slashit/src/view/shopper/wallet.dart';
import 'package:slashit/src/view/splash.dart';
import 'package:slashit/src/widget/paystack.dart';

class Routes {
  static const HOME = Home.routeName;
  static const DEBITCARDS = DebitCards.routeName;
  static const TRANSACTIONS = Transactions.routeName;
  static const root = Splash.routeName;
  static const PAYSTACK = PayStackWidget.routeName;
  static const FEATURES = FeaturesList.routeName;
  static const WALLET = WalletScreen.routeName;
  static const UPCOMMINGREPAYMENTS = UpcommingRepayments.routeName;
  static const TRANSACTIONDETAILS = OrderInfo.routeName;
  static const LOGINSHOPPER = LoginShopper.routeName;
  static const LOGINBUSINESS = LoginBusiness.routeName;
  static const REGISTERUSER = RegisterUser.routeName;
  static const CREATEPAYMENTS = RequestMoney.routeName;
  static const ADDMONEY = AddMoney.routeName;
  static const REQUESTS = Requests.routeName;
  static const SHOPPERREQUESTS = ShopperRequests.routeName;
  static const BANKTRANSFER = BankTransfer.routeName;
  static const BARCODE = BarCodeScanning.routeName;
  static const REQUESTDETAILS = RequestDetails.routeName;
  final route = <String, WidgetBuilder>{
    Routes.HOME: (context) => Home(),
    Routes.root: (context) => Splash(),
    Routes.REQUESTDETAILS: (context) => RequestDetails(),
    Routes.TRANSACTIONS: (context) => Transactions(),
    Routes.BARCODE: (context) => BarCodeScanning(),
    Routes.REQUESTS: (context) => Requests(),
    Routes.SHOPPERREQUESTS: (context) => ShopperRequests(),
    Routes.UPCOMMINGREPAYMENTS: (context) => UpcommingRepayments(),
    Routes.TRANSACTIONDETAILS: (context) => OrderInfo(),
    Routes.LOGINSHOPPER: (context) => LoginShopper(),
    Routes.DEBITCARDS: (context) => DebitCards(),
    Routes.FEATURES: (context) => FeaturesList(),
    Routes.WALLET: (context) => WalletScreen(),
    Routes.PAYSTACK: (context) => PayStackWidget(),
    Routes.LOGINBUSINESS: (context) => LoginBusiness(),
    Routes.REGISTERUSER: (context) => RegisterUser(),
    Routes.ADDMONEY: (context) => AddMoney(),
    Routes.CREATEPAYMENTS: (context) => RequestMoney(),
    Routes.BANKTRANSFER: (context) => BankTransfer(),
  };
}
