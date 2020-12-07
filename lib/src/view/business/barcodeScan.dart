import 'dart:io';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:barcode_scan/model/scan_result.dart';
import 'package:flutter/material.dart';
import 'package:graphql/utilities.dart' show multipartFileFrom;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:share/share.dart';
import 'package:slashit/src/repository/user_repository.dart';
import 'package:slashit/src/utils/url.dart';
import 'package:slashit/src/view/business/business.dart';
import 'package:slashit/src/view/qrCode.dart';

import '../home.dart';

class BarCodeScanning extends StatefulWidget {
  static const routeName = "/barCode";
  String title, note, desc,customerName;
  int amount;
  File file;
  BarCodeScanning({this.title, this.note,this.customerName, this.desc, this.amount, this.file});

  @override
  _BarCodeScanningState createState() => _BarCodeScanningState();
}

class _BarCodeScanningState extends State<BarCodeScanning> {
  ScanResult scanResult;
//  final _flashOnController = TextEditingController(text: "Flash on");
//  final _flashOffController = TextEditingController(text: "Flash off");
//  final _cancelController = TextEditingController(text: "Cancel");
//
//  var _aspectTolerance = 0.00;
//  var _selectedCamera = -1;
//  var _useAutoFocus = true;
//  var _autoEnableFlash = false;
//
//  static final _possibleFormats = BarcodeFormat.values.toList()
//    ..removeWhere((e) => e == BarcodeFormat.unknown);
//
//  List<BarcodeFormat> selectedFormats = [..._possibleFormats];

  String orderID;
  ProgressDialog _pr;

  @override
  void initState() {
    _pr = ProgressDialog(context, type: ProgressDialogType.Normal);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (orderID == null) {
          Navigator.pop(context);
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, Home.routeName, (route) => false);
        }
        return true;
      },
      child: Scaffold(
        appBar: _header(),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
//              RaisedButton(
//                  onPressed: () => scan(),
//                  shape: StadiumBorder(),
//                  color: PrimaryColor,
//                  child: Row(
//                    mainAxisSize: MainAxisSize.min,
//                    children: <Widget>[
//                      Icon(
//                        Icons.camera,
//                        color: Colors.white,
//                      ),
//                      Text(
//                        " Scan   ",
//                        style: TextStyle(color: Colors.white, fontSize: 20),
//                      )
//                    ],
//                  )),
              QrCode(
                qrCode: qrCode,
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Scan QR Code to accept payment",
                    style: TextStyle(color: Colors.black54, fontSize: 18),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

//  _scan(List value, List key) async {
//
//  }

  Future qrCode(String type, String id) async {
    if (orderID == null) {
      _pr.show();

      print("type ${type} id ${id}");
      String url = "";
      if (widget.file != null) {
        url = await _uploadImage();
      }
      var paymentInput = {
        "title": "\"${widget.title}\"",
        "desc": "\"${widget.desc}\"",
        "amount": "${widget.amount}",
        "note": "\"${widget.note}\"",
        "attachment": "\"${url}\"",
        "shopper": "\"${id}\"",
        "customerName": "\"${widget.customerName}\""
      };

      bool result = await UserRepository.instance.createPaymentReq(
          paymentInput, (type == "installment") ? "INSTALLMENT" : "WALLET");
      _pr.hide();
      if (result) {
        _goTobusinessPage();
      }
    }
  }
//
//  Future scan() async {
//    try {
//      var options = ScanOptions(
//        strings: {
//          "cancel": "cancel",
//          "flash_on": _flashOnController.text,
//          "flash_off": _flashOffController.text,
//        },
//        restrictFormat: selectedFormats,
//        useCamera: _selectedCamera,
//        autoEnableFlash: _autoEnableFlash,
//        android: AndroidOptions(
//          aspectTolerance: _aspectTolerance,
//          useAutoFocus: _useAutoFocus,
//        ),
//      );
//
//      scanResult = await BarcodeScanner.scan(options: options);
//
//      List value = json.decode(scanResult.rawContent).values.toList();
//      List key = json.decode(scanResult.rawContent).keys.toList();
//
//      if ((key.length == 2 && value.length == 2) &&
//          (key[0] == "type" && key[1] == "id")) {
//        _pr.show();
//
//        String url = "";
//        if (widget.file != null) {
//          url = await _uploadImage();
//        }
//        var paymentInput = {
//          "title": "\"${widget.title}\"",
//          "desc": "\"${widget.desc}\"",
//          "amount": "${widget.amount}",
//          "note": "\"${widget.note}\"",
//          "attachment": "\"${url}\"",
//          "shopper": "\"${value[1]}\"",
//        };
//
//        bool result = await UserRepository.instance.createPaymentReq(
//            paymentInput, (key[0] == "installment") ? "INSTALLMENT" : "WALLET");
//        _pr.hide();
//        if (result) {
//          _goTobusinessPage();
//        }
//      } else {
//        showToastMsg("Please scan a valid QR code");
//      }
//    } on PlatformException catch (e) {
//      if (e.code == BarcodeScanner.cameraAccessDenied) {
//        showToastMsg('The user did not grant the camera permission!');
//      } else {
//        showToastMsg('Unknown error: $e');
//      }
//    }
//  }

  _goTobusinessPage() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => Business(),
        ),
        ModalRoute.withName('/business'));
  }

  _header() {
    return PreferredSize(
      preferredSize: Size.fromHeight(100),
      child: Container(
        height: 100,
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Padding(
                padding: EdgeInsets.only(left: 20, top: 50),
                child: Icon(
                  Icons.arrow_back,
                  size: 30,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => _shareLink(),
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 20, top: 50),
                  child: Text("Share Link",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _shareLink() async {
    print("copy Link");

    if (orderID == null) {
      String url = "";
      if (widget.file != null) {
        url = await _uploadImage();
      }

      var paymentInput = {
        "title": "\"${widget.title}\"",
        "desc": "\"${widget.desc}\"",
        "amount": "${widget.amount}",
        "attachment": "\"${url}\"",
        "note": "\"${widget.note}\"",
        "customerName": "\"${widget.customerName}\""
      };

      _pr.show();
      orderID = await UserRepository.instance
          .createPaymentReqCopy(paymentInput, "WALLET_INSTALLMENT");
      if (orderID != null) {
        String link = "${URL.WEBSITE_URL}request-order/${orderID}";
        _pr.hide();
        await Share.share(link);
      }
      _pr.hide();
    } else {
      String link = "${URL.WEBSITE_URL}request-order/${orderID}";
      await Share.share(link);
    }
  }

  @override
  void dispose() {
//    _flashOffController?.dispose();
//    _flashOnController?.dispose();
//    _cancelController?.dispose();
    super.dispose();
  }

  Future<String> _uploadImage() async {
    final muiltiPartFile = await multipartFileFrom(widget.file);
    return await UserRepository.instance.uploadImage(muiltiPartFile);
  }
}
