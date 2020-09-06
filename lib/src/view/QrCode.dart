import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';
import 'package:slashit/src/resources/colors.dart';
import 'package:slashit/src/utils/showToast.dart';

class QrCode extends StatefulWidget {
  Function qrCode;

  QrCode({this.qrCode});

  @override
  _QrCodeState createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> with TickerProviderStateMixin {
  bool _camState = false;
  Animation<double> scanerAnim;
  AnimationController animCtrl;

  _qrCallback(String code) {
    animCtrl.dispose();
    setState(() {
      _camState = true;
      showToastMsg(code);
    });

    print("json decode ${json.decode(code)}");
    List value = json.decode(code).values.toList();
    List key = json.decode(code).keys.toList();

    if ((key.length == 2 && value.length == 2) &&
        (key[0] == "type" && key[1] == "id")) {
      widget.qrCode(value[0], value[1]);
    } else {
      showToastMsg("Invalid QR Code");
    }
  }

  @override
  void initState() {
    super.initState();

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
  }

  @override
  void dispose() {
    animCtrl?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return !_camState
        ? Stack(
            children: <Widget>[
              Center(
                child: Container(
                  height: 250,
                  width: 250,
                  decoration: BoxDecoration(
                      border: Border.all(color: PrimaryColor, width: 2)),
                  child: QRBarScannerCamera(
                    onError: (context, error) => Text(
                      error.toString(),
                      style: TextStyle(color: Colors.red),
                    ),
                    qrCodeCallback: (code) {
                      _qrCallback(code);
                    },
                  ),
                ),
              ),
              Center(
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
              )
            ],
          )
        : Container(
            height: 250,
            width: 250,
          );
  }
}
