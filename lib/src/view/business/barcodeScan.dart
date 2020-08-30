import 'dart:convert';
import 'dart:io';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:barcode_scan/model/scan_result.dart';
import 'package:barcode_scan/platform_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql/utilities.dart' show multipartFileFrom;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:share/share.dart';
import 'package:slashit/src/repository/user_repository.dart';
import 'package:slashit/src/utils/showToast.dart';
import 'package:slashit/src/view/business/business.dart';

class BarCodeScanning extends StatefulWidget {
  static const routeName = "/barCode";
  String title, note, desc;
  int amount;
  File file;
  BarCodeScanning({this.title, this.note, this.desc, this.amount, this.file});

  @override
  _BarCodeScanningState createState() => _BarCodeScanningState();
}

class _BarCodeScanningState extends State<BarCodeScanning> {
  ScanResult scanResult;
  final _flashOnController = TextEditingController(text: "Flash on");
  final _flashOffController = TextEditingController(text: "Flash off");
  final _cancelController = TextEditingController(text: "Cancel");

  var _aspectTolerance = 0.00;
  var _selectedCamera = -1;
  var _useAutoFocus = true;
  var _autoEnableFlash = false;

  static final _possibleFormats = BarcodeFormat.values.toList()
    ..removeWhere((e) => e == BarcodeFormat.unknown);

  List<BarcodeFormat> selectedFormats = [..._possibleFormats];

  ProgressDialog _pr;

  @override
  void initState() {
    _pr = ProgressDialog(context, type: ProgressDialogType.Normal);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _header(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RaisedButton(
                onPressed: () => scan(),
                shape: StadiumBorder(),
                color: Colors.blue,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.camera,
                      color: Colors.white,
                    ),
                    Text(
                      " Scan   ",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ],
                )),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  FontAwesomeIcons.qrcode,
                  color: Colors.green,
                  size: 30,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Scan a barcode to accept payment",
                  style: TextStyle(color: Colors.green, fontSize: 18),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future scan() async {
    try {
      var options = ScanOptions(
        strings: {
          "cancel": "  X  ",
          "flash_on": _flashOnController.text,
          "flash_off": _flashOffController.text,
        },
        restrictFormat: selectedFormats,
        useCamera: _selectedCamera,
        autoEnableFlash: _autoEnableFlash,
        android: AndroidOptions(
          aspectTolerance: _aspectTolerance,
          useAutoFocus: _useAutoFocus,
        ),
      );

      scanResult = await BarcodeScanner.scan(options: options);

      List value = json.decode(scanResult.rawContent).values.toList();
      List key = json.decode(scanResult.rawContent).keys.toList();

      if ((key.length == 2 && value.length == 2) &&
          (key[0] == "type" && key[1] == "id")) {
        _pr.show();

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
          "shopper": "\"${value[1]}\"",
        };

        bool result = await UserRepository.instance.createPaymentReq(
            paymentInput, (key[0] == "installment") ? "INSTALLMENT" : "WALLET");
        _pr.hide();
        if (result) {
          _goTobusinessPage();
        }
      } else {
        showToastMsg("Please scan a valid QR code");
      }
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        showToastMsg('The user did not grant the camera permission!');
      } else {
        showToastMsg('Unknown error: $e');
      }
    }
  }

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
              onTap: () => _copyLink(),
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

  _copyLink() async {
    print("copy Link");
    String url = "";
    if (widget.file != null) {
      url = await _uploadImage();
    }

    var paymentInput = {
      "title": "\"${widget.title}\"",
      "desc": "\"${widget.desc}\"",
      "amount": "${widget.amount}",
      "attachment": "\"${url}\"",
      "note": "\"${widget.note}\""
    };

    _pr.show();
    String orderId = await UserRepository.instance
        .createPaymentReqCopy(paymentInput, "WALLET_INSTALLMENT");
    if (orderId != null) {
      String link = "https://ez-pm.herokuapp.com/request-order/${orderId}";
      Share.share(link);
    }
    _pr.hide();
  }

  @override
  void dispose() {
    _flashOffController?.dispose();
    _flashOnController?.dispose();
    _cancelController?.dispose();
    super.dispose();
  }

  Future<String> _uploadImage() async {
    final muiltiPartFile = await multipartFileFrom(widget.file);
    return await UserRepository.instance.uploadImage(muiltiPartFile);
  }
}
