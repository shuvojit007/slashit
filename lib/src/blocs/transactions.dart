// Package imports:
import 'package:rxdart/rxdart.dart';
import 'package:slashit/src/models/transaction.dart';
import 'package:slashit/src/repository/user_repository.dart';

class TransactionsBloc {
  final _isMoreLoadingSubject = BehaviorSubject<bool>();
  Stream<bool> get isMoreLoading => _isMoreLoadingSubject.stream;

  final _transactionFetcher = BehaviorSubject<List<Result>>();
  Stream<List<Result>> get allTransaction => _transactionFetcher.stream;

  List<Result> _transaction = [];
  featchAllTransctions(int limit, offset) async {
    print("featchAllTransctions offset  ${offset}");
    if (offset != 0) {
      _isMoreLoadingSubject.add(true);
    }
    TransactionsModel transaction =
        await UserRepository.instance.fetchTransactions(limit, offset);
    List<Result> res = transaction.result;
    _isMoreLoadingSubject.add(false);

    for (final Result result in res) {
      _transaction.add(result);
    }
    _transactionFetcher.sink.add(_transaction);
  }

  featchAllTransctionsWithLimit(int limit) async {
    print("featchAllTransctions");
    TransactionsModel transaction =
        await UserRepository.instance.fetchTransactions(8, 0);
    List<Result> res = transaction.result;
    _transactionFetcher.sink.add(res);
  }

  dispose() {
    _transactionFetcher?.close();
  }
}
