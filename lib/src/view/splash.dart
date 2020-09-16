import 'package:flutter/material.dart';
import 'package:slashit/src/di/locator.dart';
import 'package:slashit/src/graphql/client.dart';
import 'package:slashit/src/utils/prefmanager.dart';
import 'package:slashit/src/view/auth/login_shopper.dart';

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
//        String token = locator<PrefManager>().token;
//        if (token != null && token != "null") {
//          GraphQLConfiguration.setToken(token);
//          Navigator.pushNamedAndRemoveUntil(
//              context, Home.routeName, (route) => false);
//        } else {
//          print("TOKEN IS NULL");
//          Navigator.pushNamedAndRemoveUntil(
//              context, LoginShopper.routeName, (route) => false);
//        }

        locator<PrefManager>().token = "null";
        GraphQLConfiguration.removeToken();
        Navigator.pushNamedAndRemoveUntil(
            context, LoginShopper.routeName, (route) => false);
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
                  width: 200.0,
                  height: 200.0,
                  child: Center(
                    child: Image.asset(
                      "assets/images/slashit.jpeg",
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
