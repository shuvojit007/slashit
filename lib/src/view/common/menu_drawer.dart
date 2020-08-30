import 'package:flutter/material.dart';

class CollapsingDrawer extends StatefulWidget {
  @override
  _CollapsingDrawerState createState() => _CollapsingDrawerState();
}

class _CollapsingDrawerState extends State<CollapsingDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width:150.0,
      child: Column(
        children: <Widget>[
          ListView.builder(
              itemBuilder: (ctx, index) {
                return Text(navigationItems[index].title,);
              },
              itemCount: navigationItems.length)
        ],
      ),
    );
  }
}

class NavigationModel {
  String title;

  NavigationModel(this.title);
}

List<NavigationModel> navigationItems = [
  NavigationModel("Settings"),
  NavigationModel("Settings"),
  NavigationModel("Settings"),
  NavigationModel("Settings"),
];
