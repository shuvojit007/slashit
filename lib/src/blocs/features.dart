// Package imports:
import 'package:rxdart/rxdart.dart';
import 'package:slashit/src/models/features_model.dart';
import 'package:slashit/src/repository/user_repository.dart';

class FeaturesBloc {
  /**
   * We are creating a PublishSubject object whose responsibility is to add the data
   * which it got from the server in form of ItemModel object and pass it to the
   * UI screen as stream.
   **/
  final _featuresFetcher = PublishSubject<List<Result>>();

  Stream<List<Result>> get allFeatures => _featuresFetcher.stream;

  featchAllFeatures() async {
    print("featchAllFeatures");
    Features features = await UserRepository.instance.feachFeatures();
    List<Result> res = features.result;
    _featuresFetcher.sink.add(res);
  }

  dispose() {
    _featuresFetcher.close();
  }
}
