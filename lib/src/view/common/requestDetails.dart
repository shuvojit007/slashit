import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:share/share.dart';
import 'package:slashit/src/models/paymentReq.dart';
import 'package:slashit/src/resources/colors.dart';
import 'package:slashit/src/resources/text_styles.dart';
import 'package:slashit/src/utils/showToast.dart';
import 'package:slashit/src/utils/timeformat.dart';

class RequestDetails extends StatefulWidget {
  static const routeName = "/requestDetails";
  Result data;

  RequestDetails({this.data});

  @override
  _RequestDetailsState createState() => _RequestDetailsState();
}

class _RequestDetailsState extends State<RequestDetails> {
  ProgressDialog _pr;

  @override
  void initState() {
    _pr = ProgressDialog(context, type: ProgressDialogType.Normal);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: creemWhite,
      appBar: AppBar(
        title: Text("Requests", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        actions: <Widget>[
          if (widget.data.status == "PENDING") ...[
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: GestureDetector(
                onTap: _shareLink,
                child: Icon(
                  Icons.share,
                  size: 25,
                  color: Colors.black54,
                ),
              ),
            )
          ]
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              color: Colors.white,
              height: 100,
              margin: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "₦ ${widget.data.amount}",
                    style: RequestDetials1,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Created ${getTime(widget.data.createdAt)}",
                    style: RequestDetials2,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${widget.data.orderId}",
                    style: RequestDetials3,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              color: Colors.white,
              margin: EdgeInsets.only(left: 20, right: 20),
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Title : ${widget.data.title}",
                    style: RequestDetials4,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Descriptions : ${widget.data.desc}",
                    style: RequestDetials4,
                  ),
                  if (widget.data.shopper != null) ...[
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Customer : ${widget.data.shopper.email}",
                      style: RequestDetials4,
                    ),
                  ],
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Amount : ₦ ${widget.data.amount}",
                    style: RequestDetials4,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Note : ${widget.data.note}",
                    style: RequestDetials4,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              _getStatus(widget.data.status),
              style: RequestDetials5,
            ),
          ],
        ),
      ),
    );
  }

  _getStatus(String status) {
    switch (status) {
      case "PENDING":
        return "Payment is pending";
      case "COMPLETED":
        return "Payment was completed";
      case "APPROVED":
        return "Payment was approved";
      case "DENIED":
        return "Payment was denied";
      default:
        return "Payment is ${status.toLowerCase()}";
    }
  }

  _shareLink() async {
    if (widget.data.orderId != null) {
      String link =
          "https://ez-pm.herokuapp.com/request-order/${widget.data.orderId}";

      await Share.share(link);
    } else {
      showToastMsg("No order id found");
    }
  }
}
