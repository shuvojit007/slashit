// Flutter imports:
import 'package:flutter/material.dart';

class AcceptRequest extends StatefulWidget {
  Function pushData;
  String id;

  AcceptRequest({this.pushData, this.id});

  @override
  _AcceptRequestState createState() => _AcceptRequestState();
}

class _AcceptRequestState extends State<AcceptRequest> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 0.0,
      child: Container(
        height: 200,
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  "Are you sure you want to accept this requests.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 25),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    textColor: Colors.white,
                    shape: StadiumBorder(),
                    color: Colors.blue,
                    onPressed: () => Navigator.pop(context),
                    child: Text("NOT NOW"),
                  ),
                  SizedBox(width: 15),
                  RaisedButton(
                    textColor: Colors.white,
                    shape: StadiumBorder(),
                    color: Colors.blue,
                    onPressed: () =>
                        {Navigator.pop(context), widget.pushData(widget.id)},
                    child: Text("ACCEPT"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
