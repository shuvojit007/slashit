import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slashit/src/blocs/repayment/repayment_bloc.dart';
import 'package:slashit/src/blocs/repayment/repayment_bloc_event.dart';
import 'package:slashit/src/blocs/repayment/repayment_bloc_state.dart';
import 'package:slashit/src/models/upcommingPayments.dart';
import 'package:slashit/src/resources/text_styles.dart';
import 'package:slashit/src/utils/timeformat.dart';
import 'package:slashit/src/view/shopper/orderInfo.dart';

class UpcommingRepayments extends StatefulWidget {
  static const routeName = "/repayments";
  @override
  _UpcommingRepaymentsState createState() => _UpcommingRepaymentsState();
}

class _UpcommingRepaymentsState extends State<UpcommingRepayments> {
  List<Color> colors = [Colors.blue, Colors.green, Colors.yellow, Colors.red];
  RepaymentBloc _bloc;

  @override
  void initState() {
    _bloc = BlocProvider.of<RepaymentBloc>(context);
    BlocProvider.of<RepaymentBloc>(context).add(GetRepayment());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upcoming Repayment"),
      ),
      body: BlocBuilder(
        bloc: _bloc,
        builder: (BuildContext context, RepaymentBlocState state) {
          if (state is RepaymentBlocLoaded) {
            return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: state.res.length,
                itemBuilder: (BuildContext ctx, int index) {
                  return _cardView(state.res[index]);
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  _cardView(Result data) {
    return GestureDetector(
      onTap: () => _goToOrderDetails(data),
      child: Container(
        height: 100,
        margin: EdgeInsets.only(left: 10, right: 10),
        child: Card(
          child: Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10, top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("# ${data.orderId}", style: Repayments1),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${getDateTime(data.createdAt)}",
                      style: Repayments2,
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Text(
                    "NGN ${data.amount}",
                    style: Repayments3,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _goToOrderDetails(data) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => OrderInfo(
                  data: data,
                )));
  }
}
