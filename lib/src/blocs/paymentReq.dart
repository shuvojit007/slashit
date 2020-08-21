// Package imports:
import 'package:rxdart/rxdart.dart';
import 'package:slashit/src/models/paymentReq.dart';
import 'package:slashit/src/repository/user_repository.dart';

class PaymentReqBloc {
  final _paymentReqFetcher = PublishSubject<List<Result>>();

  Stream<List<Result>> get allPaymentReq => _paymentReqFetcher.stream;

  fetchAllPaymentReq() async {
    print("fetchAllPaymentReq");
    PaymentReq paymentReq = await UserRepository.instance.fetchPaymentReq();
    List<Result> res = paymentReq.result;
    _paymentReqFetcher.sink.add(res);
  }

  dispose() {
    _paymentReqFetcher.close();
  }
}
