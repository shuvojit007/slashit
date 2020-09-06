import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slashit/src/blocs/repayment/repayment_bloc.dart';
import 'package:slashit/src/blocs/repayment/repayment_bloc_event.dart';
import 'package:slashit/src/blocs/repayment/repayment_bloc_state.dart';
import 'package:slashit/src/models/upcommingPayments.dart';
import 'package:slashit/src/resources/text_styles.dart';
import 'package:slashit/src/utils/number.dart';
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

  ScrollController _controller = ScrollController();
  bool scrlDown = true;
  int offset = 0;

  _scrollListener() async {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      print(" Scroll Lister FetchMore Called");
      offset = offset + 1;
      BlocProvider.of<RepaymentBloc>(context).add(GetRepayment(20, offset));
    }
  }

  _progressDialog() {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
            margin: EdgeInsets.only(bottom: 30),
            child: CircularProgressIndicator()));
  }

  @override
  void initState() {
    _bloc = BlocProvider.of<RepaymentBloc>(context);
    BlocProvider.of<RepaymentBloc>(context).add(GetRepayment(0, 0));
    _controller.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upcoming Repayment", style: userTitle),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Stack(
        children: <Widget>[
          BlocBuilder(
            bloc: _bloc,
            builder: (BuildContext context, RepaymentBlocState state) {
              if (state is RepaymentBlocLoaded) {
                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    controller: _controller,
                    itemCount: state.res.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      return _cardView(state.res[index]);
                    });
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
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
                    "₦ ${formatNumberValue(data.amount)}",
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
