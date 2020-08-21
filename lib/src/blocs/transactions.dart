// Package imports:
import 'package:rxdart/rxdart.dart';
import 'package:slashit/src/models/transaction.dart';
import 'package:slashit/src/repository/user_repository.dart';

class TransactionsBloc {
  final _transactionFetcher = PublishSubject<List<Result>>();

  Stream<List<Result>> get allTransaction => _transactionFetcher.stream;

  featchAllTransctions() async {
    print("featchAllTransctions");
    TransactionsModel transaction =
        await UserRepository.instance.fetchTransactions(100);
    List<Result> res = transaction.result;
    _transactionFetcher.sink.add(res);
  }

  featchAllTransctionsWithLimit(int limit) async {
    print("featchAllTransctions");
    TransactionsModel transaction =
        await UserRepository.instance.fetchTransactions(8);
    List<Result> res = transaction.result;
    _transactionFetcher.sink.add(res);
  }

  dispose() {
    _transactionFetcher.close();
  }
}
