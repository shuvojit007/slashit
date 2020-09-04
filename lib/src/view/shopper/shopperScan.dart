import 'package:barcode_scan/gen/protos/protos.pb.dart';
import 'package:barcode_scan/gen/protos/protos.pbenum.dart';
import 'package:barcode_scan/model/android_options.dart';
import 'package:barcode_scan/model/scan_options.dart';
import 'package:barcode_scan/platform_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:slashit/src/resources/colors.dart';
import 'package:slashit/src/resources/text_styles.dart';
import 'package:slashit/src/utils/showToast.dart';

class ShopperScan extends StatefulWidget {
  int index;

  ShopperScan({this.index});

  @override
  _ShopperScanState createState() => _ShopperScanState();
}

class _ShopperScanState extends State<ShopperScan> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  int _groupValue = -1;

  var _aspectTolerance = 0.00;
  var _selectedCamera = -1;
  var _useAutoFocus = true;
  var _autoEnableFlash = false;
  static final _possibleFormats = BarcodeFormat.values.toList()
    ..removeWhere((e) => e == BarcodeFormat.unknown);
  List<BarcodeFormat> selectedFormats = [..._possibleFormats];
  ScanResult scanResult;

  @override
  void initState() {
    setState(() {
      _groupValue = widget.index;
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Payment", style: userTitle),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          _userTitle(),
          SizedBox(
            height: 20,
          ),
          _userAmount(),
          SizedBox(
            height: 20,
          ),
          Column(
            children: <Widget>[
              radioBtn(
                  title: "Wallet",
                  value: 0,
                  function: (newValue) =>
                      setState(() => _groupValue = newValue)),
              radioBtn(
                  title: "Installment",
                  value: 1,
                  function: (newValue) =>
                      setState(() => _groupValue = newValue)),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: RaisedButton(
              onPressed: scan,
              color: PrimaryColor,
              shape: StadiumBorder(),
              child: Text(
                "Scan QR Code",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget radioBtn({String title, int value, Function function}) {
    return RadioListTile(
      value: value,
      groupValue: _groupValue,
      onChanged: function,
      title: Text(title),
    );
  }

  _userTitle() {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: TextField(
        controller: _emailController,
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

  Future scan() async {
    try {
      var options = ScanOptions(
        strings: {
          "cancel": "cancel",
          "flash_on": "Flash on",
          "flash_off": "Flash off",
        },
        restrictFormat: selectedFormats,
        useCamera: _selectedCamera,
        autoEnableFlash: _autoEnableFlash,
        android: AndroidOptions(
          aspectTolerance: _aspectTolerance,
          useAutoFocus: _useAutoFocus,
        ),
      );

      scanResult = (await BarcodeScanner.scan(options: options)) as ScanResult;
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        showToastMsg('The user did not grant the camera permission!');
      } else {
        showToastMsg('Unknown error: $e');
      }
    }
  }
}
