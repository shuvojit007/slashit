// Package imports:
import 'package:rxdart/rxdart.dart';
import 'package:slashit/src/models/transaction.dart';
import 'package:slashit/src/repository/user_repository.dart';

class TransactionsBloc {
  final _transactionFetcher = PublishSubject<List<Result>>();

  Stream<List<Result>> get allTransaction => _transactionFetcher.stream;

  featchAllTransctions() async {
    print("featchAllTransctions");
    Transactions transaction =
        await UserRepository.instance.fetchTransactions();
    List<Result> res = transaction.result;
    _transactionFetcher.sink.add(res);
  }

  dispose() {
    _transactionFetcher.close();
  }
}
