import 'package:flutter/material.dart';
import 'package:slashit/src/di/locator.dart';
import 'package:slashit/src/utils/prefmanager.dart';
import 'package:slashit/src/view/business/business.dart';
import 'package:slashit/src/view/shopper/shopper.dart';

class Home extends StatefulWidget {
  static const routeName = "/home";
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _pageIndex = 0;
  bool shopper = true;
  @override
  void initState() {
    shopper = locator<PrefManager>().role == "shopper";

//    if (shopper) {
//      _pageIndex = 0;
//    } else {
//      _pageIndex = 1;
//    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: shopper ? Shopper() : Business(),

//
//      SafeArea(
//        top: false,
//        child: IndexedStack(
//          index: _pageIndex,
//          children: <Widget>[
//            Shopper(),
//            Business(),
//          ],
//        ),
//      ),
//      bottomNavigationBar: BottomNavigationBar(
//        onTap: (int index) {
//          if (index == 1 && shopper) {
//            showToastMsg(
//                "To access this you have to login as Business Account");
//          } else if (index == 0 && !shopper) {
//            showToastMsg("To access this you have to login as Shopper");
//          }
//        },
//        currentIndex: _pageIndex,
//        items: [
//          BottomNavigationBarItem(
//              icon: Icon(FontAwesomeIcons.shoppingCart),
//              activeIcon: shopper
//                  ? Icon(FontAwesomeIcons.shoppingCart)
//                  : Icon(FontAwesomeIcons.shoppingCart, color: Colors.grey),
//              title: Text("Shopper")),
//          BottomNavigationBarItem(
//              icon: Icon(FontAwesomeIcons.businessTime),
//              title: Text("Business")),
//        ],
//      ),
    );
  }
}
