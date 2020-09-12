import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:slashit/src/resources/colors.dart';
import 'package:slashit/src/resources/text_styles.dart';
import 'package:slashit/src/utils/showToast.dart';
import 'package:slashit/src/view/business/barcodeScan.dart';

class RequestMoney extends StatefulWidget {
  static const routeName = "/request_money";
  @override
  _RequestMoneyState createState() => _RequestMoneyState();
}

class _RequestMoneyState extends State<RequestMoney> {
  TextEditingController _title = TextEditingController();
  TextEditingController _desc = TextEditingController();
  TextEditingController _amount = TextEditingController();
  TextEditingController _note = TextEditingController();
  File _imageFile;
  String attachment = "Add Attachment";
  bool imageLoad = false;

  @override
  void dispose() {
    _title?.dispose();
    _desc?.dispose();
    _amount?.dispose();
    _note?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Payments", style: userTitle),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[body(), _actionBtn()],
        ),
      ),
    );
  }

  body() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 15, right: 15, top: 20),
      child: Column(
        children: <Widget>[
          SizedBox(height: 16),
          _inputFields("Add Title", _title),
          SizedBox(height: 16),
          _inputFields("Description", _desc),
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: TextField(
              controller: _amount,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
//              inputFormatters: <TextInputFormatter>[
//                WhitelistingTextInputFormatter.digitsOnly
//              ],
              decoration: InputDecoration(
                labelText: "Amount",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: PrimaryColor, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                ),
              ),
              cursorColor: appbartitle,
            ),
          ),
          SizedBox(height: 16),
          _inputFields("Note", _note),
          SizedBox(height: 16),
          if (!imageLoad) ...[
            GestureDetector(
              onTap: _pickImage,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Add photo",
                    style: TextStyle(color: PrimaryColor, fontSize: 17),
                  ),
                ),
              ),
            ),
          ] else ...[
            Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: 80,
                  width: 80,
                  child: Stack(
                    children: <Widget>[
                      Image.file(
                        new File(attachment),
                        width: 80,
                        height: 80,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              attachment = null;
                              imageLoad = false;
                            });
                          },
                          child: Icon(
                            Icons.close,
                            size: 25,
                            color: Colors.red,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
          SizedBox(height: 16),
        ],
      ),
    );
  }

  _inputFields(String name, TextEditingController _con) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: TextField(
        controller: _con,
        decoration: InputDecoration(
          labelText: name,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: PrimaryColor, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
          ),
        ),
        cursorColor: appbartitle,
      ),
    );
  }

  _actionBtn() {
    return RaisedButton(
        onPressed: () => _createPaymentReq(),
        child: Text('  Create  ', style: SignInStyle),
        color: PrimaryColor,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)));
  }

  _createPaymentReq() async {
    if (_title.text.isNotEmpty &&
        _note.text.isNotEmpty &&
        _desc.text.isNotEmpty &&
        _amount.text.isNotEmpty) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BarCodeScanning(
                    title: _title.text,
                    note: _note.text,
                    desc: _desc.text,
                    amount: int.parse(_amount.text),
                    file: _imageFile,
                  )));
    } else {
      showToastMsg("Please fill up the form");
    }
  }

  _pickImage() async {
    File selected = await ImagePicker.pickImage(source: ImageSource.gallery);
    _imageFile = selected;
    _cropImage();
  }

  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: _imageFile.path,
      iosUiSettings: IOSUiSettings(
        minimumAspectRatio: 1.0,
      ),
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      maxWidth: 512,
      maxHeight: 512,
    );

    setState(() {
      attachment = cropped.path;
      imageLoad = true;
      _imageFile = cropped;
    });
  }
}
