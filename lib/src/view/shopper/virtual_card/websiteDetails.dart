import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:slashit/src/resources/colors.dart';
import 'package:slashit/src/utils/homeExtra.dart';
import 'package:slashit/src/view/shopper/virtual_card/vcard.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../home.dart';
import 'addVCardDetails.dart';

class WebsiteDetailsArguments {
  final String link;
  final String title;

  WebsiteDetailsArguments(this.link, this.title);
}

class WebsiteDetails extends StatefulWidget {
  static const routeName = "/websiteDetails";
  String link, title = "";

  WebsiteDetails({this.link, this.title});

  @override
  _WebsiteDetailsState createState() => _WebsiteDetailsState();
}

class _WebsiteDetailsState extends State<WebsiteDetails> {
  InAppWebViewController webView;
  TextEditingController _url = TextEditingController();

  bool isLoaded = false;
  double progress = 0;

  String url = "";

  @override
  void initState() {
    //  url = widget.link;
    _url.text = "    ${url}";
    super.initState();
  }

  @override
  void dispose() {
    _url?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final WebsiteDetailsArguments args =
        ModalRoute.of(context).settings.arguments;
    url = args.link;
    return WillPopScope(
      onWillPop: () async {
        if (webView != null && await webView.canGoBack()) {
          print("webview");
          webView.goBack();
        } else {
          print("webview null");
          Navigator.pop(context);
        }
        return false;
      },
      child: Scaffold(
        appBar: _header(),
        body: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 50),
              child: InAppWebView(
                initialUrl: url,
                initialHeaders: {},
                initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                    debuggingEnabled: true,
                  ),
                ),
                onWebViewCreated: (InAppWebViewController controller) {
                  webView = controller;
                },
                onLoadStart: (InAppWebViewController controller, String url) {
                  setState(() {
                    this.url = url;
                    _url.text = "    ${url}";
                    isLoaded = false;
                  });
                },
                onLoadStop:
                    (InAppWebViewController controller, String url) async {
                  setState(() {
                    this.url = url;
                    isLoaded = true;
                  });
                },
                onProgressChanged:
                    (InAppWebViewController controller, int progress) {},
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Visibility(
                visible: isLoaded,
                child: Container(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        textColor: Colors.white,
                        shape: StadiumBorder(),
                        color: PrimaryColor,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => addVCardDetails()));
                        },
                        child: Text("Pay in 4 on ${args.title}"),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => VCard()));
                        },
                        child: Icon(
                          FontAwesomeIcons.creditCard,
                          color: PrimaryColor,
                          size: 30,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Visibility(
                  visible: !isLoaded, child: CircularProgressIndicator()),
            )
          ],
        ),
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
                margin: EdgeInsets.only(top: 40, left: 20, right: 50),
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: IntrinsicWidth(
                  stepHeight: 40,
                  stepWidth: double.infinity,
                  child: TextField(
                    controller: _url,
                    onSubmitted: (String value) {
                      webView.loadUrl(url: value);
                    },
                    //  enabled: false,
                    decoration: InputDecoration.collapsed(
                      hintText: null,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 5,
                bottom: 2,
                child: PopupMenuButton(
                  elevation: 3.2,
                  onCanceled: () {
                    print('You have not chossed anything');
                  },
                  tooltip: 'This is tooltip',
                  onSelected: optionSelected,
                  itemBuilder: (BuildContext context) {
                    return website.map((Option choice) {
                      return PopupMenuItem(
                        value: choice,
                        child: Text(choice.title),
                      );
                    }).toList();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  optionSelected(Option option) {
    switch (option.id) {
      case "refresh":
        webView.reload();
        break;
      case "browser":
        _launchURL();
        break;
      case "goback":
        Navigator.pushNamedAndRemoveUntil(
            context, Home.routeName, (route) => false);
        break;
    }
  }

  _launchURL() async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
