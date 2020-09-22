// Package imports:
import 'package:sembast/sembast.dart';
import 'package:slashit/src/models/serviceFee.dart';

import 'app_database.dart';

class DBLogic {
  final _service = intMapStoreFactory.store("SERVICE");
  Future<Database> get db async => await AppDatabase.instance.database;

  //==========User Section  ====================

  Future addService(ServiceFee serviceFee) async {
    await _service.add(await db, serviceFee.toMap());
  }

  Future<List<ServiceFee>> getService() async {
    final snapshot = await _service.find(await db);
    if (snapshot == null) {
      return null;
    }
    return snapshot.map((map) {
      final sup = ServiceFee.fromMap(map.value);
      return sup;
    }).toList();
  }

  Future deleteAll() async {
    print("ResetData Called");
    await _service.delete(await db);
    print("ResetData Finished");

    List<ServiceFee> service = await dbLogic.getService();
    print(service.toString());
  }
}

final DBLogic dbLogic = DBLogic();
