// Package imports:
import 'package:rxdart/rxdart.dart';
import 'package:slashit/src/models/website.dart';
import 'package:slashit/src/repository/user_repository.dart';

class SearchWebsiteBloc {
  final _isMoreLoadingSubject = BehaviorSubject<bool>();
  Stream<bool> get isMoreLoading => _isMoreLoadingSubject.stream;

  final _websiteFetcher = BehaviorSubject<List<Result>>();
  Stream<List<Result>> get allWebsite => _websiteFetcher.stream;

  List<Result> _websiteList = [];

  int _count = 0;

  fetchAllWebsitewithText(int limit, offset, String searchText) async {
    print("fetchAllWebsite offset  ${offset}");
    if (offset != 0) {
      _isMoreLoadingSubject.add(true);
    }
    Website website =
        await UserRepository.instance.fetchWebsite(limit, offset, searchText);
    List<Result> res = website.result;
    _isMoreLoadingSubject.add(false);

    if (searchText.isNotEmpty && searchText != "") {
      print("fetchAllWebsite 1 ${res.length}");
      _count = res.length;
      _websiteFetcher.sink.add(res);
    } else {
      print("fetchAllWebsite 2");
      for (final Result result in res) {
        _websiteList.add(result);
      }
      _count = _websiteList.length;
      _websiteFetcher.sink.add(_websiteList);
    }
  }

  int get count => _count;

  fetchAllWebsite() async {
    if (_websiteList.length > 0) {
      _websiteFetcher.sink.add(_websiteList);
    } else {
      Website website = await UserRepository.instance.fetchWebsite(20, 0, "");
      List<Result> res = website.result;
      _websiteFetcher.sink.add(res);
    }
  }

  dispose() {
    _websiteFetcher.close();
    _isMoreLoadingSubject?.close();
  }
}
