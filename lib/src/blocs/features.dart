// Package imports:
import 'package:rxdart/rxdart.dart';
import 'package:slashit/src/models/features_model.dart';
import 'package:slashit/src/repository/user_repository.dart';

class FeaturesBloc {
  final _isMoreLoadingSubject = BehaviorSubject<bool>();
  Stream<bool> get isMoreLoading => _isMoreLoadingSubject.stream;

  final _featuresFetcher = BehaviorSubject<List<Result>>();
  Stream<List<Result>> get allFeatures => _featuresFetcher.stream;

  List<Result> _features = [];
  featchAllFeatures(int limit, int offset) async {
    print("featchAllFeatures offset  ${offset}");
    if (offset != 0) {
      _isMoreLoadingSubject.add(true);
    }
    Features features =
        await UserRepository.instance.feachFeatures(limit, offset);
    List<Result> res = features.result;
    _isMoreLoadingSubject.add(false);

    for (final Result result in res) {
      _features.add(result);
    }
    _featuresFetcher.sink.add(_features);
  }

  dispose() {
    _featuresFetcher?.close();
  }
}
