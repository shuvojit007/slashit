import 'package:flutter/material.dart';
import 'package:slashit/src/resources/colors.dart';
import 'package:slashit/src/resources/text_styles.dart';

class RequestDetails extends StatefulWidget {
  static const routeName = "/requestDetails";
  @override
  _RequestDetailsState createState() => _RequestDetailsState();
}

class _RequestDetailsState extends State<RequestDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: creemWhite,
      appBar: AppBar(
        title: Text("Requests"),
        centerTitle: true,
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
                    "NGN 1,200.00",
                    style: RequestDetials1,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Created Jun 21, 2020 5:38 PM",
                    style: RequestDetials2,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "T257L24870X",
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
                    "Title : Shuvojit Kar",
                    style: RequestDetials4,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Descriptions : Lorasem ipsum asdasd asdew asdasd wreva qweqwe ",
                    style: RequestDetials4,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Customer : sh@gmail.com",
                    style: RequestDetials4,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Amount : NGN 500,00.00",
                    style: RequestDetials4,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Note : This is Note ",
                    style: RequestDetials4,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Payment was successful",
              style: RequestDetials5,
            ),
          ],
        ),
      ),
    );
  }
}
