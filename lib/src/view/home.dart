import 'package:flutter/material.dart';
import 'package:slashit/src/di/locator.dart';
import 'package:slashit/src/utils/prefmanager.dart';
import 'package:slashit/src/view/business/business.dart';
import 'package:slashit/src/view/shopper/shopper.dart';
import 'package:slashit/src/view/shopper/virtual_card/search.dart';

class Home extends StatefulWidget {
  static const routeName = "/home";
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [Shopper(), Search()];
  bool shopper = true;
  @override
  void initState() {
    shopper = locator<PrefManager>().role == "shopper";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: shopper ? _children[_currentIndex] : Business(),
      bottomNavigationBar: Visibility(
          visible: shopper,
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: onTabTapped,
            items: [
              BottomNavigationBarItem(
                icon: _currentIndex == 0
                    ? new Image.asset(
                        'assets/images/shoppingprimary.png',
                        width: 30,
                        height: 25,
                      )
                    : new Image.asset(
                        'assets/images/shoppinggrey.png',
                        width: 30,
                        height: 25,
                      ),
                title: const Text('Shop'),
              ),
              BottomNavigationBarItem(
                icon: const Icon(
                  Icons.search,
                ),
                title: const Text('Search'),
              ),
            ],
          )),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
