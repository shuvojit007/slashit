// Package imports:
import 'package:rxdart/rxdart.dart';
import 'package:slashit/src/models/vcard.dart';
import 'package:slashit/src/repository/user_repository.dart';

class VcardBloc {
  final _cardFetcher = BehaviorSubject<List<Result>>();
  Stream<List<Result>> get allVcards => _cardFetcher.stream;

  List<Result> _vCard = [];

  List<Result> get vCard => _vCard;

  featchAllCard() async {
    print("featchAllCard ");

    VcardModel vcardModel = await UserRepository.instance.fetchVCard();
    List<Result> res = vcardModel.results;
    _vCard.clear();
    for (final Result result in res) {
      _vCard.add(result);
    }
    _cardFetcher.sink.add(_vCard);
  }

  dispose() {
    _cardFetcher?.close();
  }
}
