import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';
import 'package:slashit/src/blocs/wallet/wallet_bloc.dart';
import 'package:slashit/src/blocs/wallet/wallet_bloc_event.dart';
import 'package:slashit/src/repository/user_repository.dart';
import 'package:slashit/src/resources/colors.dart';
import 'package:slashit/src/resources/text_styles.dart';
import 'package:slashit/src/utils/showToast.dart';
import 'package:slashit/src/widget/progress_btn/iconed_button.dart';
import 'package:slashit/src/widget/progress_btn/progress_button.dart';

import '../home.dart';

class ShopperScan extends StatefulWidget {
  int index;

  ShopperScan({this.index});

  @override
  _ShopperScanState createState() => _ShopperScanState();
}

class _ShopperScanState extends State<ShopperScan>
    with TickerProviderStateMixin {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  Animation<double> scanerAnim;
  AnimationController animCtrl;

  bool isScan = false;
  bool isLoading = false;

  StateSetter setModalState;
  ButtonState stateOnlyText = ButtonState.idle;

  @override
  void initState() {
    Timer(Duration(seconds: 1), () {
      _modalBottomSheetMenu();
    });

    animCtrl =
        AnimationController(vsync: this, duration: Duration(milliseconds: 700));
    scanerAnim = Tween<double>(begin: -50, end: 100).animate(animCtrl);
    animCtrl.addStatusListener((AnimationStatus status) {
      if (AnimationStatus.completed == status) {
        animCtrl.repeat(
          reverse: true,
        );
      }
    });
    animCtrl.forward();

    super.initState();
  }

  @override
  void dispose() {
    animCtrl?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Flexible(
            child: Stack(
              children: <Widget>[
                QRBarScannerCamera(
                  onError: (context, error) => Text(
                    error.toString(),
                    style: TextStyle(color: Colors.red),
                  ),
                  qrCodeCallback: scan,
                ),
                Positioned(
                  top: 100,
                  left: 50,
                  right: 50,
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: isScan ? PrimaryColor : Colors.grey,
                            width: 2)),
                  ),
                ),
                Positioned(
                  top: 100,
                  left: 80,
                  right: 80,
                  child: Visibility(
                    visible: isScan,
                    child: Container(
                      height: 200,
                      child: AnimatedBuilder(
                          animation: scanerAnim,
                          builder: (BuildContext context, Widget chile) {
                            return Transform.translate(
                              offset: Offset(0, scanerAnim.value),
                              child: Container(
                                width: 150,
                                child: Divider(
                                  color: Colors.green,
                                  thickness: 2,
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _modalBottomSheetMenu() {
    showModalBottomSheet(
        context: context,
        elevation: 0,
        barrierColor: Colors.white.withOpacity(0),
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (builder) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 20, top: 20, bottom: 20),
                      child: Text(
                        "Create Payment",
                        style: shopperScan,
                      ),
                    ),
                    _userTitle(),
                    SizedBox(
                      height: 20,
                    ),
                    _userAmount(),
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 30),
                        child: ProgressButton.icon(
                            iconedButtons: {
                              ButtonState.idle: IconedButton(
                                  text: "Scan QR Code to pay",
                                  icon: Icon(Icons.send, color: Colors.white),
                                  color: PrimaryColor),
                              ButtonState.loading: IconedButton(
                                  text: "Loading", color: PrimaryColor),
                              ButtonState.fail: IconedButton(
                                  text: "Failed",
                                  icon: Icon(Icons.cancel, color: Colors.white),
                                  color: Colors.red.shade300),
                              ButtonState.success: IconedButton(
                                  text: "Success",
                                  icon: Icon(
                                    Icons.check_circle,
                                    color: Colors.white,
                                  ),
                                  color: Colors.green.shade400)
                            },
                            onPressed: () {
                              if (_titleController.text.isNotEmpty &&
                                  _amountController.text.isNotEmpty) {
                                setState(() {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  isScan = true;
                                });

                                this.setModalState = setModalState;
                                this.setModalState(() {
                                  stateOnlyText = ButtonState.loading;
                                });
                              } else {
                                showToastMsg("Please fill up the form");
                              }
                            },
                            state: stateOnlyText),
                      ),
                    )
                  ],
                )
//                  : Container(
//                      height: 260,
//                      child: Column(
//                        crossAxisAlignment: CrossAxisAlignment.center,
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: <Widget>[
//                          CircularProgressIndicator(),
//                          SizedBox(
//                            height: 20,
//                          ),
//                          Text(
//                            "Please scan QR code to create payment",
//                            style: shopperScan,
//                          ),
//                        ],
//                      ),
//                    ),
                );
          });
        }).whenComplete(() => Navigator.pop(context));
  }

  _userTitle() {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: TextField(
        controller: _titleController,
        enabled: !isScan,
        decoration: InputDecoration(
          labelText: "Title",
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: PrimaryColor, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
          ),
          //    prefixIcon: Icon(Icons.mail_outline),
        ),
        cursorColor: appbartitle,
      ),
    );
  }

  _userAmount() {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: TextField(
        enabled: !isScan,
        controller: _amountController,
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          labelText: "Amount",
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: PrimaryColor, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
          ),
          //    prefixIcon: Icon(Icons.mail_outline),
        ),
        cursorColor: appbartitle,
      ),
    );
  }

  Future scan(String code) async {
    if (isScan && !isLoading) {
      List value = json.decode(code).values.toList();
      List key = json.decode(code).keys.toList();

      if ((key.length == 2 && value.length == 2) &&
          (key[0] == "type" && key[1] == "id") &&
          value[0] == "business") {
        // animCtrl?.dispose();
        isLoading = true;

        bool result = await UserRepository.instance.createPaymentReqByShopper(
            _titleController.text,
            int.parse(_amountController.text),
            widget.index == 0 ? "WALLET" : "INSTALLMENT",
            value[1]);

        if (result) {
          // this.setModalState(() {
          //   stateOnlyText = ButtonState.success;
          // });

          showToastMsg("Successful");
          await UserRepository.instance.fetchUser();
          BlocProvider.of<WalletBloc>(context).add(GetWallet());

          Navigator.pushNamedAndRemoveUntil(
              context, Home.routeName, (route) => false);
        } else {
          this.setModalState(() {
            stateOnlyText = ButtonState.fail;
          });
        }
      } else {
        showToastMsg("Please scan a valid QR code");
      }
    }
  }
}
