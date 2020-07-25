import 'package:flutter/material.dart';
import 'package:slashit/src/resources/colors.dart';
import 'package:slashit/src/resources/text_styles.dart';

class CreatePayemts extends StatefulWidget {
  static const routeName = "/create_payment";
  @override
  _CreatePayemtsState createState() => _CreatePayemtsState();
}

class _CreatePayemtsState extends State<CreatePayemts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Payments"),
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
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black87),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        children: <Widget>[
          SizedBox(height: 16),
          _inputFields("Title"),
          SizedBox(height: 16),
          _inputFields("Description"),
          SizedBox(height: 16),
          _inputFields("Customer"),
          SizedBox(height: 16),
          _inputFields("Amount"),
          SizedBox(height: 16),
          _inputFields("Note"),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  _inputFields(String name) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: TextField(
        controller: null,
        decoration: InputDecoration(
          labelText: name,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: PrimrayColor, width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2.0),
          ),
        ),
        cursorColor: appbartitle,
      ),
    );
  }

  _actionBtn() {
    return Container(
      height: 100,
      margin: EdgeInsets.only(
        left: 15,
        right: 15,
      ),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: RaisedButton(
                onPressed: () {},
                child: Text('   Cancel   ', style: SignInStyle),
                color: PrimrayColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0))),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: RaisedButton(
                onPressed: () {},
                child: Text('   Create  ', style: SignInStyle),
                color: PrimrayColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0))),
          )
        ],
      ),
    );
  }
}
