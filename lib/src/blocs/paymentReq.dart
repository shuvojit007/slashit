// Package imports:
import 'package:rxdart/rxdart.dart';
import 'package:slashit/src/models/paymentReq.dart';
import 'package:slashit/src/repository/user_repository.dart';

class PaymentReqBloc {
  final _isMoreLoadingSubject = BehaviorSubject<bool>();
  Stream<bool> get isMoreLoading => _isMoreLoadingSubject.stream;

  final _paymentReqFetcher = BehaviorSubject<List<Result>>();
  Stream<List<Result>> get allPaymentReq => _paymentReqFetcher.stream;

  List<Result> _paymentReq = [];

  fetchAllPaymentReq(int limit, offset) async {
    print("fetchAllPaymentReq offset  ${offset}");
    if (offset != 0) {
      _isMoreLoadingSubject.add(true);
    }

    PaymentReq paymentReq =
        await UserRepository.instance.fetchPaymentReq(limit, offset);
    List<Result> res = paymentReq.result;
    _isMoreLoadingSubject.add(false);

    for (final Result result in res) {
      _paymentReq.add(result);
    }
    _paymentReqFetcher.sink.add(_paymentReq);
  }

  fetchAllPaymentReqshopper() async {
    print("fetchAllPaymentReq");
    PaymentReq paymentReq =
        await UserRepository.instance.fetchPaymentReqShopper();
    List<Result> res = paymentReq.result;
    _paymentReqFetcher.sink.add(res);
  }

  dispose() {
    _paymentReqFetcher.close();
    _isMoreLoadingSubject?.close();
  }
}
