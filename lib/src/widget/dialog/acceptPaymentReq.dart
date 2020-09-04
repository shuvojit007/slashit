// Flutter imports:
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:slashit/src/repository/user_repository.dart';
import 'package:slashit/src/resources/colors.dart';
import 'package:slashit/src/resources/text_styles.dart';
import 'package:slashit/src/utils/number.dart';

class AcceptPaymentRequest extends StatefulWidget {
  String createdAt, title, orderId;
  int amount;

  AcceptPaymentRequest({this.createdAt, this.title, this.orderId, this.amount});

  @override
  _AcceptRequestState createState() => _AcceptRequestState();
}

class _AcceptRequestState extends State<AcceptPaymentRequest> {
  ProgressDialog _pr;

  @override
  void initState() {
    _pr = ProgressDialog(context, type: ProgressDialogType.Normal);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 0.0,
      child: Container(
        width: double.infinity,
        height: 180,
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  "Title : ${widget.title}",
                  textAlign: TextAlign.start,
                  style: payment,
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  "Order : #${widget.orderId}",
                  textAlign: TextAlign.start,
                  style: payment,
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  "Amount : ₦ ${formatNumberValue(widget.amount)}",
                  textAlign: TextAlign.start,
                  style: payment,
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
                    color: PrimaryColor,
                    onPressed: _rejectPaymentReq,
                    child: Text("Reject"),
                  ),
                  SizedBox(width: 15),
                  RaisedButton(
                    textColor: Colors.white,
                    shape: StadiumBorder(),
                    color: PrimaryColor,
                    onPressed: _acceptPayment,
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

  _acceptPayment() async {
    _pr.show();
    await UserRepository.instance.acceptPaymentReq(widget.orderId);
    _pr.hide();
    Navigator.pop(context);
  }

  _rejectPaymentReq() async {
    _pr.show();
    await UserRepository.instance.rejectPaymentReq(widget.orderId);
    _pr.hide();
    Navigator.pop(context);
  }
}
