import 'dart:async';
import 'dart:collection';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:slashit/src/blocs/features.dart';
import 'package:slashit/src/blocs/wallet/wallet_bloc.dart';
import 'package:slashit/src/blocs/wallet/wallet_bloc_event.dart';
import 'package:slashit/src/blocs/wallet/wallet_bloc_state.dart';
import 'package:slashit/src/di/locator.dart';
import 'package:slashit/src/graphql/client.dart';
import 'package:slashit/src/graphql/graph_api.dart';
import 'package:slashit/src/models/features_model.dart';
import 'package:slashit/src/resources/assets.dart';
import 'package:slashit/src/resources/colors.dart';
import 'package:slashit/src/resources/str.dart';
import 'package:slashit/src/resources/text_styles.dart';
import 'package:slashit/src/utils/homeExtra.dart';
import 'package:slashit/src/utils/innerDrawer.dart';
import 'package:slashit/src/utils/number.dart';
import 'package:slashit/src/utils/prefmanager.dart';
import 'package:slashit/src/utils/url.dart';
import 'package:slashit/src/utils/userData.dart';
import 'package:slashit/src/view/auth/login_shopper.dart';
import 'package:slashit/src/view/common/bankTransfer.dart';
import 'package:slashit/src/view/common/transactions.dart';
import 'package:slashit/src/view/shopper/debitCards.dart';
import 'package:slashit/src/view/shopper/repayment.dart';
import 'package:slashit/src/view/shopper/shopperScan.dart';
import 'package:slashit/src/view/shopper/shopper_requests.dart';
import 'package:slashit/src/view/shopper/wallet.dart';
import 'package:slashit/src/widget/dialog/acceptPaymentReq.dart';
import 'package:url_launcher/url_launcher.dart';

import 'featuresList.dart';

class Shopper extends StatefulWidget {
  @override
  _ShopperState createState() => _ShopperState();
}

class _ShopperState extends State<Shopper> with SingleTickerProviderStateMixin {
  int value = 5000;
  int count = 0;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<InnerDrawerState> _innerDrawerKey =
      GlobalKey<InnerDrawerState>();
  FeaturesBloc _bloc;
  StreamSubscription _pyamentStream;

  @override
  void initState() {
    BlocProvider.of<WalletBloc>(context).add(GetWallet());
    _bloc = FeaturesBloc();
    _bloc.featchAllFeatures();
    stream();
    super.initState();
  }

  stream() {
    _pyamentStream = GraphQLConfiguration()
        .clientToQuery()
        .subscribe(Operation(
            documentNode: gql(
          GraphApi.instance.paymentSubscription(locator<PrefManager>().userID),
        )))
        .listen(
      (event) {
        LinkedHashMap value = event.data;
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => AcceptPaymentRequest(
            createdAt: value["NewPaymentReq"]["createdAt"],
            title: value["NewPaymentReq"]["title"],
            amount: value["NewPaymentReq"]["amount"],
            orderId: value["NewPaymentReq"]["orderId"],
          ),
        );
      },
      onError: (err) {
        print("subscription err ${err.toString()}");
      },
      onDone: () {},
    );
  }

  @override
  void dispose() {
    _bloc?.dispose();
    _pyamentStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InnerDrawer(
      key: _innerDrawerKey,
      onTapClose: true,
      swipe: true,
      colorTransitionChild: Colors.black54,
      colorTransitionScaffold: Colors.transparent,
      offset: IDOffset.horizontal(0.0),
      rightAnimationType: InnerDrawerAnimation.quadratic,
      rightChild: Container(
        color: Colors.white,
        padding: EdgeInsets.only(left: 10),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            for (Option option in shopper) ...[
              _menuWidget(option),
              SizedBox(
                height: 20,
              ),
            ]
          ],
        ),
      ),
      scaffold: Scaffold(
        backgroundColor: Colors.white,
        key: scaffoldKey,
        body: _body(),
        appBar: _header(),
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          // _header(),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 35,
            margin: EdgeInsets.only(left: 5, right: 5),
            decoration: BoxDecoration(
                color: PrimaryColor,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Center(
              child: Text(
                "Spend Limit",
                style: shopperText1,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              "₦ ${formatNumberValue(locator<PrefManager>().spendLimit)}",
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
            color: PrimaryColor,
            child: Text(
              "     See Upcoming Repayments     ",
              style: shopperText3,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: 300,
            height: 55,
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
            size: 200.0,
            gapless: false,
          ),

          GestureDetector(
            onTap: _goToShopperScan,
            child: Icon(
              FontAwesomeIcons.camera,
              color: Colors.grey,
              size: 30,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          _wallet(),
          SizedBox(
            height: 50,
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 5),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Featured",
                style: shopperText4,
              ),
            ),
          ),
          _features(),
          //   _paymentSubscription()
        ],
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
                    "Slash direct",
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
                            "Available Balance | ₦ ${formatNumberValue(locator<PrefManager>().availableBalance)}",
                            style: WalletPrice,
                          );
                        } else {
                          return Text(
                            "Available Balance | ₦ 0",
                            style: WalletPrice,
                          );
                        }
                      }),
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
                      color: PrimaryColor,
                      size: 30,
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
    return PreferredSize(
      preferredSize: Size.fromHeight(85),
      child: Card(
        margin: EdgeInsets.all(0),
        child: Container(
          height: 85,
          color: Colors.white,
          width: double.infinity,
          child: Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 45, left: 20),
                child: Text(
                  "${locator<PrefManager>().name}",
                  style: userTitle,
                ),
              ),
              Positioned(
                  right: 10,
                  top: 45,
                  child: GestureDetector(
                    onTap: () {
                      _innerDrawerKey.currentState.open();
                    },
                    child: Icon(Icons.menu),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  _menuWidget(Option option) {
    return GestureDetector(
      onTap: () => _appbarOption(option),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(option.icon, size: 25.0, color: PrimaryColor),
          SizedBox(width: 10),
          Text(
            option.title,
            style: menuText,
          ),
        ],
      ),
    );
  }

  _features() {
    return StreamBuilder(
      stream: _bloc.allFeatures,
      builder: (context, AsyncSnapshot<List<Result>> snapshot) {
        if (snapshot.hasData) {
          return Container(
              width: double.infinity,
              height: 160,
              margin: EdgeInsets.only(left: 10, right: 10),
              child: _featuresView(snapshot));
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return Center(child: CircularProgressIndicator());
      },
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
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FeaturesList(0))),
              child: Container(
                child: Icon(
                  Icons.arrow_forward,
                  color: PrimaryColor,
                  size: 30,
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
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print("Could not launch $url");
    }
  }

  _goToShopperScan() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ShopperScan(index: 1,)));
  }
}
