// Package imports:

import 'package:get_it/get_it.dart';
import 'package:slashit/src/utils/prefmanager.dart';

GetIt locator = GetIt.instance;

Future setupLocator() async {
  var instance = await PrefManager.getInstance();
  locator.registerSingleton<PrefManager>(instance, signalsReady: true);
}
