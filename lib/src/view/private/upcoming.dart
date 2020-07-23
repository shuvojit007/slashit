import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:slashit/src/resources/colors.dart';
import 'package:slashit/src/resources/text_styles.dart';

class UpcomingPayment extends StatefulWidget {
  static const routeName = "/upcoming_payment";
  @override
  _UpcomingPayment createState() => _UpcomingPayment();
}

class _UpcomingPayment extends State<UpcomingPayment> {
  ProgressDialog _pr;
  final List data = [{'date': '201454', 'amount': '100'}];


  @override
  void initState() {
    _pr = ProgressDialog(context, type: ProgressDialogType.Normal);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 40),
            Padding(
                padding: EdgeInsets.only(top: 10, left: 10),
                child: IconButton(
                    icon: Icon(Icons.keyboard_backspace, color: PrimrayColor),
                    onPressed: () => Navigator.pop(context))),
            SizedBox(height: 20),
            Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Upcoming Repayment", style: createAccount),
              ],
            )),
            SizedBox(height: 30),
            ListView.builder(
                itemCount: data.length,
                itemBuilder: (context,index)=>UpComingData(jsonObject: data[index]),
                )
          ],
        ),
      ),
    );
  }
}


class UpComingData extends StatefulWidget  {
 final Map<String, String> jsonObject;

  UpComingData({this.jsonObject});

  @override
  _UpComingData createState() => _UpComingData();
}

class _UpComingData extends State<UpComingData> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Container(
        child: Row(children: makeWidgetChildren(widget.jsonObject)),
      ),
    );
  }

  List<Widget> makeWidgetChildren(jsonObject) {
    List<Widget> children = [];
    jsonObject.keys.forEach(
      (key) => {
        children.add(
          Padding(
              child: Text('${jsonObject[key]}'), padding: EdgeInsets.all(8.0)),
        )
      },
    );
    return children;
  }
}
