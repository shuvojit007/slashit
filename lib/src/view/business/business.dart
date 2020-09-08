import 'package:flutter/material.dart';
import 'package:number_display/number_display.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:slashit/src/blocs/transactions.dart';
import 'package:slashit/src/di/locator.dart';
import 'package:slashit/src/models/transaction.dart';
import 'package:slashit/src/resources/colors.dart';
import 'package:slashit/src/resources/text_styles.dart';
import 'package:slashit/src/utils/homeExtra.dart';
import 'package:slashit/src/utils/innerDrawer.dart';
import 'package:slashit/src/utils/number.dart';
import 'package:slashit/src/utils/prefmanager.dart';
import 'package:slashit/src/utils/timeformat.dart';
import 'package:slashit/src/utils/userData.dart';
import 'package:slashit/src/view/auth/login_shopper.dart';
import 'package:slashit/src/view/business/request_money.dart';
import 'package:slashit/src/view/business/requestsList.dart';
import 'package:slashit/src/view/common/bankTransfer.dart';
import 'package:slashit/src/view/common/transactions.dart';
import 'package:slashit/src/view/common/transactionsDetails.dart';

class Business extends StatefulWidget {
  @override
  _BusinessState createState() => _BusinessState();
}

class _BusinessState extends State<Business> {
  TransactionsBloc _bloc;
  final GlobalKey<InnerDrawerState> _innerDrawerKey =
      GlobalKey<InnerDrawerState>();
  final display = createDisplay(
    length: 20,
    decimal: 0,
  );

  @override
  void initState() {
    _bloc = TransactionsBloc();
    _bloc.featchAllTransctionsWithLimit(5);
    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    // TODO: implement dispose
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
            for (Option option in business) ...[
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
          appBar: _header(),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                _body(),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 5, bottom: 5),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Recents,",
                      style: shopperText4,
                    ),
                  ),
                ),
                _recentPayments(),
              ],
            ),
          )),
    );
  }

  _header() {
    return PreferredSize(
      preferredSize: Size.fromHeight(80),
      child: Card(
        margin: EdgeInsets.all(0),
        child: Container(
          height: 80,
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _body() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 35,
            margin: EdgeInsets.only(left: 10, top: 10, right: 10),
            decoration: BoxDecoration(
                color: PrimaryColor,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Center(
              child: Text(
                "Balance",
                style: shopperText1,
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: Text(
              "₦ ${formatNumberValue(locator<PrefManager>().availableBalance)}",
              style: shopperText2,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              "AVAILABLE",
              style: businessText1,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Divider(color: Colors.black26),
          ),
          QrImage(
            constrainErrorBounds: true,
            data:
                "{\"type\":\"business\",\"id\" :\"${locator<PrefManager>().uniqueId}\"}",
            version: QrVersions.auto,
            size: 250.0,
            gapless: false,
          ),
          SizedBox(
            height: 5,
          ),
          RaisedButton(
            onPressed: () =>
                Navigator.pushNamed(context, RequestMoney.routeName),
            shape: StadiumBorder(),
            color: PrimaryColor,
            child: Text(
              "     Request Money     ",
              style: shopperText3,
            ),
          ),
        ],
      ),
    );
  }

  _recentPayments() {
    return Container(
      height: 260,
      margin: EdgeInsets.only(left: 15, right: 15),
      child: StreamBuilder(
        stream: _bloc.allTransaction,
        builder: (context, AsyncSnapshot<List<Result>> snapshot) {
          if (snapshot.hasData && snapshot.data.length > 0) {
            return Column(
              children: <Widget>[
                MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: Container(
                    height: 220,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext ctx, int index) {
                          return _data(snapshot.data[index]);
                        }),
                  ),
                ),
                if (snapshot.data.length > 6) ...[
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(
                      context,
                      Transactions.routeName,
                    ),
                    child: Container(
                      margin: EdgeInsets.only(right: 15, top: 5),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "View All",
                          style: shopperText5,
                        ),
                      ),
                    ),
                  )
                ],
              ],
            );
          } else if (snapshot.hasData) {
            return Center(child: Text("No recent transaction"));
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  _data(Result data) {
    return GestureDetector(
      onTap: () => _goToTransactionDetails(data),
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 5, top: 5, left: 5),
        color: creemWhite,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      top: 8,
                    ),
                    child: Text(
                      "${data.order.title}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: businessText2,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, top: 3, bottom: 8),
                    child: Text(
                      "${getShortTime(data.createdAt)}",
                      style: businessText3,
                    ),
                  ),
                ],
              ),
            ),
//            Expanded(
//              flex: 1,
//              child: Text(
//                "${getShortTime(data.createdAt)}",
//                style: businessText2,
//              ),
//            ),
//            Expanded(
//              flex: 1,
//              child: Text(
//                "${data.order.title}",
//                maxLines: 1,
//                overflow: TextOverflow.ellipsis,
//                style: businessText2,
//              ),
//            ),
            Expanded(
              flex: 1,
              child: Text(
                "₦ ${formatNumberValue(data.order.amount)}",
                style: businessText2,
              ),
            )
          ],
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

  _appbarOption(Option options) async {
    print(options.id);
    switch (options.id) {
      case "transactions":
        Navigator.pushNamed(
          context,
          Transactions.routeName,
        );
        break;
      case "bank":
        Navigator.pushNamed(
          context,
          BankTransfer.routeName,
        );
        break;
      case "request":
        Navigator.pushNamed(
          context,
          Requests.routeName,
        );
        break;
      case "signout":
        print("singout ");
        await removeUser();
        Navigator.pushNamedAndRemoveUntil(
            context, LoginShopper.routeName, (route) => false);
        break;
    }
  }

  _goToTransactionDetails(data) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TransactionDetails(
                  data: data,
                )));
  }
}
