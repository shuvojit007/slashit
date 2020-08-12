import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:slashit/src/di/locator.dart';
import 'package:slashit/src/utils/prefmanager.dart';
import 'package:slashit/src/utils/showToast.dart';
import 'package:slashit/src/view/pages/business.dart';
import 'package:slashit/src/view/pages/shopper.dart';

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

    if (shopper) {
      _pageIndex = 0;
    } else {
      _pageIndex = 1;
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: IndexedStack(
          index: _pageIndex,
          children: <Widget>[
            Shopper(),
            Business(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          if (index == 1 && shopper) {
            showToastMsg("To access this you have to login as shopper");
          } else if (index == 0 && !shopper) {
            showToastMsg("To access this you have to login as business");
          }
        },
        currentIndex: _pageIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.shoppingCart),
              activeIcon: shopper
                  ? Icon(FontAwesomeIcons.shoppingCart)
                  : Icon(FontAwesomeIcons.shoppingCart, color: Colors.grey),
              title: Text("Shopper")),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.businessTime),
              title: Text("Business")),
        ],
      ),
    );
  }
}
