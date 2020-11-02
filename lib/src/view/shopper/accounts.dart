import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:slashit/src/models/instagramModel.dart';
import 'package:slashit/src/repository/user_repository.dart';
import 'package:slashit/src/resources/str.dart';
import 'package:slashit/src/resources/text_styles.dart';
import 'package:slashit/src/utils/showToast.dart';

class Accounts extends StatefulWidget {
  static const routeName = "/accounts";
  @override
  _AccountsState createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  ProgressDialog _pr;
  final TextEditingController _controller = TextEditingController();

  bool instaAccount = false, isLoaded = false;
  InstagramModel model;
  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Linked Accounts", style: userTitle),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        actions: <Widget>[
          if (!instaAccount) ...[
            GestureDetector(
                onTap: addInstagram,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.only(right: 10),
                    child: Text(
                      "Save  ",
                      style: billingAddress1,
                    ),
                  ),
                ))
          ]
        ],
      ),
      body: isLoaded
          ? Stack(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(left: 10, top: 10),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.instagram,
                          size: 40,
                        ),
                        SizedBox(width: 10),
                        Text("Instagram", style: accounts),
                        SizedBox(width: 10),
                        if (!instaAccount) ...[
                          Flexible(
                            child: TextField(
                              controller: _controller,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              decoration: InputDecoration(
                                hintText: "Enter your username",
                              ),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ] else ...[
                          SizedBox(width: 20),
                          Text(
                            model?.user?.instagram,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 19,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(width: 10),
                          if (model?.user?.isInstagramVerified) ...[
                            Icon(
                              Icons.verified_user,
                              color: Colors.green,
                            )
                          ]
                        ],
                        SizedBox(width: 10),
                      ],
                    )),
                if (!model?.user?.isInstagramVerified) ...[
                  Center(
                      child: Container(
                          margin: EdgeInsets.all(10),
                          child: Text(
                            Str.instaSlug,
                            style: accountsslug,
                            textAlign: TextAlign.center,
                          )))
                ]
              ],
            )
          : Center(child: CircularProgressIndicator()),
    );
  }

  @override
  void initState() {
    _pr = ProgressDialog(context, type: ProgressDialogType.Normal);
    checkServer();
    super.initState();
  }

  void checkServer() async {
    // _pr.show();
    model = await UserRepository.instance.fetchInstagram();
    isLoaded = true;
    //_pr.hide();
    setState(() {
      isLoaded = true;
      if (model?.user?.instagram != null && model?.user?.instagram.isNotEmpty) {
        instaAccount = true;
      } else {
        instaAccount = false;
      }
    });
  }

  addInstagram() async {
    if (_controller.text.isNotEmpty) {
      var profileData = {"instagram": "\"${_controller.text}\""};
      _pr.show();
      var result = await UserRepository.instance.addInstagram(profileData);
      _pr.hide();
      if (result) {
        checkServer();
      }
    } else {
      showToastMsg("Please add valid input");
    }
  }
}
