import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:slashit/src/blocs/features.dart';
import 'package:slashit/src/blocs/wallet/wallet_bloc.dart';
import 'package:slashit/src/blocs/wallet/wallet_bloc_event.dart';
import 'package:slashit/src/blocs/wallet/wallet_bloc_state.dart';
import 'package:slashit/src/di/locator.dart';
import 'package:slashit/src/models/features_model.dart';
import 'package:slashit/src/resources/assets.dart';
import 'package:slashit/src/resources/colors.dart';
import 'package:slashit/src/resources/str.dart';
import 'package:slashit/src/resources/text_styles.dart';
import 'package:slashit/src/utils/homeExtra.dart';
import 'package:slashit/src/utils/prefmanager.dart';
import 'package:slashit/src/utils/url.dart';
import 'package:slashit/src/utils/userData.dart';
import 'package:slashit/src/view/auth/login_shopper.dart';
import 'package:slashit/src/view/common/bankTransfer.dart';
import 'package:slashit/src/view/common/transactions.dart';
import 'package:slashit/src/view/shopper/debitCards.dart';
import 'package:slashit/src/view/shopper/repayment.dart';
import 'package:slashit/src/view/shopper/shopper_requests.dart';
import 'package:slashit/src/view/shopper/wallet.dart';
import 'package:slashit/src/widget/propic.dart';
import 'package:url_launcher/url_launcher.dart';

import 'featuresList.dart';

class Shopper extends StatefulWidget {
  @override
  _ShopperState createState() => _ShopperState();
}

class _ShopperState extends State<Shopper> {
  int value = 5000;
  int count = 0;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  FeaturesBloc _bloc;

  @override
  void initState() {
    BlocProvider.of<WalletBloc>(context).add(GetWallet());
    _bloc = FeaturesBloc();
    _bloc.featchAllFeatures();

    // _getPaymentReqCount();
    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _header(),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: 35,
              margin: EdgeInsets.only(left: 5, right: 5),
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Center(
                child: Text(
                  "Spend up to",
                  style: shopperText1,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                "NGN ${locator<PrefManager>().spendLimit}",
                style: shopperText2,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: Divider(color: Colors.black26),
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, UpcommingRepayments.routeName),
              shape: StadiumBorder(),
              color: Colors.blue,
              child: Text(
                "     Upcomming Repayments     ",
                style: shopperText3,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 300,
              height: 50,
              child: Text(
                Str.barcode,
                style: barcodeText,
              ),
            ),
            QrImage(
              constrainErrorBounds: true,
              data:
                  "{\"type\":\"installment\",\"id\" :\"${locator<PrefManager>().userID}\"}",
              version: QrVersions.auto,
              size: 150.0,
              gapless: false,
            ),
            SizedBox(
              height: 10,
            ),
            _wallet(),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 5),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Features",
                  style: shopperText4,
                ),
              ),
            ),
            _features(),
          ],
        ),
      ),
    );
  }

  _wallet() {
    return Container(
      height: 52,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              margin: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Wallet",
                    style: shopperText4,
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  BlocBuilder(
                      bloc: BlocProvider.of<WalletBloc>(context),
                      builder: (BuildContext ctx, WalletBlocState state) {
                        if (state is WalletBlocLoaded) {
                          return Text(
                            "Available Balance | NGN ${locator<PrefManager>().availableBalance}",
                            style: WalletPrice,
                          );
                        } else {
                          return Text(
                            "Available Balance | NGN 0",
                            style: WalletPrice,
                          );
                        }
                      }),
//                  Text(
//                    "Available Balance | NGN ${locator<PrefManager>().availableBalance}",
//                    style: WalletPrice,
//                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: EdgeInsets.only(right: 20),
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(
                    context,
                    WalletScreen.routeName,
                  ),
                  child: Container(
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.blue,
                      size: 40,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _header() {
    return Container(
      height: 100,
      color: Colors.blue,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          ProfileImage(
            photo: locator<PrefManager>().avatar,
          ),
          Container(
            margin: EdgeInsets.only(top: 55, left: 65),
            child: Text(
              "Shopper, ${locator<PrefManager>().name}",
              style: userTitle,
            ),
          ),
//          if (count != 0) ...[
//            counterWidget()
//          ] else ...[
//            zerocounterWidget(),
//          ],
          Positioned(
            right: 1,
            bottom: 15,
            child: PopupMenuButton<Option>(
              onSelected: _appbarOption,
              itemBuilder: (BuildContext context) {
                print("shopper  ${shopper.length}");
                return shopper.map((Option option) {
                  return PopupMenuItem<Option>(
                    value: option,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(option.icon, size: 20.0, color: PrimrayColor),
                        SizedBox(width: 10),
                        Text(option.title),
                      ],
                    ),
                  );
                }).toList();
              },
            ),
          )
        ],
      ),
    );
  }

  _features() {
    return Container(
      width: double.infinity,
      height: 160,
      margin: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(border: Border.all(color: Colors.black87)),
      child: StreamBuilder(
        stream: _bloc.allFeatures,
        builder: (context, AsyncSnapshot<List<Result>> snapshot) {
          if (snapshot.hasData) {
            return _featuresView(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  _featuresView(AsyncSnapshot<List<Result>> snapshot) {
    return GridView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: snapshot.data.length > 6 ? 6 : snapshot.data.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
        itemBuilder: (BuildContext ctx, int index) {
          if (index > 4) {
            return GestureDetector(
              onTap: () => Navigator.pushNamed(
                context,
                FeaturesList.routeName,
              ),
              child: Container(
                child: Icon(
                  FontAwesomeIcons.chevronCircleRight,
                  color: Colors.blue,
                  size: 50,
                ),
              ),
            );
          } else {
            return GestureDetector(
              onTap: () => _launchURL(snapshot.data[index].link),
              child: Container(
                margin: EdgeInsets.all(5),
                child: CachedNetworkImage(
                    imageUrl: "${URL.S3_URL}${snapshot.data[index].img}",
                    fit: BoxFit.cover,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Image.asset(
                          Assets.Placeholder,
                          width: 100,
                          fit: BoxFit.cover,
                          height: 100,
                        )),
              ),
            );
          }
        });
  }

  _appbarOption(Option options) {
    switch (options.id) {
      case "transactions":
        Navigator.pushNamed(
          context,
          Transactions.routeName,
        );
        break;
      case "request":
        Navigator.pushNamed(context, ShopperRequests.routeName);
        break;
      case "bank":
        Navigator.pushNamed(
          context,
          BankTransfer.routeName,
        );
        break;
      case "cards":
        Navigator.pushNamed(
          context,
          DebitCards.routeName,
        );
        break;
      case "signout":
        print("singout ");
        removeUser();
        Navigator.pushNamedAndRemoveUntil(
            context, LoginShopper.routeName, (route) => false);
        break;
    }
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print("Could not launch $url");
    }
  }

//  counterWidget() {
//    return Positioned(
//      right: 50,
//      bottom: 25,
//      child: GestureDetector(
//        onTap: () => Navigator.pushNamed(context, ShopperRequests.routeName),
//        child: Badge(
//          badgeContent: Text("${count}"),
//          child: Icon(
//            FontAwesomeIcons.bell,
//            color: Colors.white,
//          ),
//        ),
//      ),
//    );
//  }
//
//  zerocounterWidget() {
//    return Positioned(
//      right: 50,
//      bottom: 25,
//      child: GestureDetector(
//        onTap: () => Navigator.pushNamed(context, ShopperRequests.routeName),
//        child: Icon(FontAwesomeIcons.bell, color: Colors.white),
//      ),
//    );
//  }
}
