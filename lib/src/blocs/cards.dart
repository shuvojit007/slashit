// Package imports:
import 'package:rxdart/rxdart.dart';
import 'package:slashit/src/models/cards.dart';
import 'package:slashit/src/repository/user_repository.dart';

class CardsBloc {
  final _cardsFetcher = PublishSubject<List<Result>>();

  Stream<List<Result>> get allCards => _cardsFetcher.stream;

  featchAllCards() async {
    print("featchAllCards");
    Cards cards = await UserRepository.instance.fetchCards();
    List<Result> res = cards.result;
    _cardsFetcher.sink.add(res);
  }

  dispose() {
    _cardsFetcher.close();
  }
}
