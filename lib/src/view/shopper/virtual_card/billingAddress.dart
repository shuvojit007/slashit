import 'package:flutter/material.dart';
import 'package:flutter_country_picker/country.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:slashit/src/di/locator.dart';
import 'package:slashit/src/resources/colors.dart';
import 'package:slashit/src/utils/prefmanager.dart';

class BillingAddress extends StatefulWidget {
  @override
  _BillingAddressState createState() => _BillingAddressState();
}

class _BillingAddressState extends State<BillingAddress> {
  TextEditingController _address = TextEditingController();
  TextEditingController _city = TextEditingController();
  TextEditingController _state = TextEditingController();
  TextEditingController _postal = TextEditingController();
  Country _selected;
  ProgressDialog _pr;
  String address = "", city = "", state = "", postal = "", country = "";

  @override
  void initState() {
    _pr = ProgressDialog(context, type: ProgressDialogType.Normal);

    _address.text = "333 Fremont Street";
    _city.text = "San Francisco";
    _state.text = "California";
    _postal.text = "94105";
    // _selected = Country.findByIsoCode("+1");

//    if (locator<PrefManager>().address != "null") {
//      _address.text = locator<PrefManager>().address;
//      address = locator<PrefManager>().address;
//    }
//    if (locator<PrefManager>().city != "null") {
//      _city.text = locator<PrefManager>().city;
//      city = locator<PrefManager>().city;
//    }
//    if (locator<PrefManager>().state != "null") {
//      _state.text = locator<PrefManager>().state;
//      state = locator<PrefManager>().state;
//    }
//    if (locator<PrefManager>().postalcode != "null") {
//      _postal.text = locator<PrefManager>().postalcode;
//      postal = locator<PrefManager>().postalcode;
//    }
    if (locator<PrefManager>().country != "null") {
      _selected = Country.findByIsoCode(locator<PrefManager>().country);
      country = locator<PrefManager>().country;
    } else {
      print("_selected $_selected");
    }

    print("_selected ${locator<PrefManager>().country}");
    super.initState();
  }

  @override
  void dispose() {
    _address?.dispose();
    _city?.dispose();
    _state?.dispose();
    _postal?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Billing Address ", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        actions: <Widget>[
//          GestureDetector(
//              onTap: _checkBillingAddress,
//              child: Align(
//                alignment: Alignment.centerRight,
//                child: Container(
//                  padding: EdgeInsets.only(right: 10),
//                  child: Text(
//                    "Save  ",
//                    style: billingAddress1,
//                  ),
//                ),
//              ))
        ],
      ),
      body: SingleChildScrollView(
        child: _body(),
      ),
    );
  }

//  _checkBillingAddress() async {
//    if ((address.isNotEmpty && address == _address.text) &&
//        (city.isNotEmpty && city == _city.text) &&
//        (state.isNotEmpty && state == _state.text) &&
//        (postal.isNotEmpty && postal == _postal.text) &&
//        (country.isNotEmpty && country == _selected.isoCode)) {
//      print("all are same");
//      Navigator.pop(context);
//    } else {
//      if (_address.text.isNotEmpty &&
//          _city.text.isNotEmpty &&
//          _state.text.isNotEmpty &&
//          _postal.text.isNotEmpty &&
//          _selected != null) {
//        print("all are same 2");
//        _pr.show();
//        bool result = await UserRepository.instance.updateBilling(_address.text,
//            _city.text, _state.text, _selected.isoCode, _postal.text);
//        _pr.hide();
//        if (result) {
//          updateSharedPref(_address.text, _city.text, _state.text,
//              _selected.isoCode, _postal.text);
//          Navigator.pop(context);
//        }
//      } else {
//        showToastMsg("Please fill up all the inputs");
//      }
//    }
//  }
//
//  updateSharedPref(String address, String city, String state, String country,
//      String postal) {
//    locator<PrefManager>().state = state;
//    locator<PrefManager>().address = address;
//    locator<PrefManager>().city = city;
//    locator<PrefManager>().country = country;
//    locator<PrefManager>().postalcode = postal;
//  }

  _body() {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.only(left: 15, right: 15, top: 20),
        child: Column(children: <Widget>[
          SizedBox(height: 16),
          _inputFields("Address", _address),
          SizedBox(height: 16),
          _inputFields("City", _city),
          SizedBox(height: 16),
          _inputFields("State", _state),
          SizedBox(height: 16),
          _inputFields("Postal", _postal),
          SizedBox(height: 16),
          Container(
            height: 55,
            width: double.infinity,
            padding: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1.0)),
            child: Stack(
              children: <Widget>[
                Align(alignment: Alignment.centerLeft, child: Text("Country")),
                Align(
                    alignment: Alignment.centerRight,
                    child: CountryPicker(
                      showDialingCode: true,
                      onChanged: (Country country) {
                        setState(() {
                          _selected = country;
                        });
                        print("selected ${_selected.isoCode}");
                      },
                      //  selectedCountry: _selected,
                    ))
              ],
            ),
          ),
        ]));
  }

  _inputFields(String name, TextEditingController _con) {
    return TextField(
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
    );
  }
}
