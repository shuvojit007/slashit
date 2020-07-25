import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:slashit/src/view/pages/business.dart';
import 'package:slashit/src/view/pages/shopper.dart';

class Home extends StatefulWidget {
  static const routeName = "/home";
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _pageIndex = 0;

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
          setState(() {
            _pageIndex = index;
          });
        },
        currentIndex: _pageIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.shoppingCart),
              title: Text("Shopper")),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.businessTime),
              title: Text("Business")),
        ],
      ),
    );
  }
}
