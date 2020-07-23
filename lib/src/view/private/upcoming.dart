import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:slashit/src/resources/text_styles.dart';

class UpcomingPayment extends StatefulWidget {
  static const routeName = "/upcoming_payment";
  @override
  _UpcomingPayment createState() => _UpcomingPayment();
}

class _UpcomingPayment extends State<UpcomingPayment> {
  ProgressDialog _pr;
  final List data = [
    {'date': '201454', 'amount': '100'}
  ];

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
        appBar: AppBar(
          title: Text("Upcoming Repayment", style: createAccount),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) => _cardView(),
        ));
  }

  Widget _cardView() {
    return Card(
      elevation: 3,
      child: Container(
        decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        height: 100,
        width: 100,
        child: Stack(
          children: <Widget>[
            const Padding(
              child: Text("Amount"),
              padding: const EdgeInsets.only(top: 15, left: 15),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, right: 15),
              child: Align(
                alignment: Alignment.topRight,
                child: Text("10 PM"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
