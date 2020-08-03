import 'package:flutter/material.dart';
import 'package:slashit/src/di/locator.dart';
import 'package:slashit/src/graphql/client.dart';
import 'package:slashit/src/resources/text_styles.dart';
import 'package:slashit/src/utils/prefmanager.dart';
import 'package:slashit/src/view/auth/login_shopper.dart';

import 'home.dart';

class Splash extends StatefulWidget {
  static const routeName = "/";
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeInCubic);
    controller.forward();

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
        if (locator<PrefManager>().token != null) {
          GraphQLConfiguration.setToken(locator<PrefManager>().token);
          Navigator.pushNamedAndRemoveUntil(
              context, Home.routeName, (route) => false);
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, LoginShopper.routeName, (route) => false);
        }
      } else if (status == AnimationStatus.dismissed) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FadeTransition(
                opacity: animation,
                child: Container(
                  width: 250.0,
                  height: 250.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Center(
                    child: Text(
                      "Slashit",
                      style: splashText,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
