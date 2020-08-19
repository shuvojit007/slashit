// Package imports:
import 'package:rxdart/rxdart.dart';
import 'package:slashit/src/models/upcommingPayments.dart';
import 'package:slashit/src/repository/user_repository.dart';

class RepaymentsBloc {
  final _repaymentsFetcher = PublishSubject<List<Result>>();

  Stream<List<Result>> get allRepayments => _repaymentsFetcher.stream;

  featchAllRepayments() async {
    print("featchAllFeatures");
    UpcommingPayments upcommingPayments =
        await UserRepository.instance.upCommingRepayments();
    List<Result> res = upcommingPayments.result;
    _repaymentsFetcher.sink.add(res);
  }

  dispose() {
    _repaymentsFetcher.close();
  }
}
