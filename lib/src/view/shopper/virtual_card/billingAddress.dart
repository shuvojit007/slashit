import 'package:flutter/material.dart';
import 'package:flutter_country_picker/country.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import 'package:slashit/src/resources/colors.dart';
import 'package:slashit/src/resources/text_styles.dart';

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

  @override
  void dispose() {
    _address?.dispose();
    _city?.dispose();
    _state?.dispose();
    _postal?.dispose();
    // TODO: implement dispose
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
          GestureDetector(
              onTap: () {},
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
        ],
      ),
      body: SingleChildScrollView(
        child: _body(),
      ),
    );
  }

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
                      },
                      selectedCountry: _selected,
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
