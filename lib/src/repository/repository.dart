//// Dart imports:
//import 'dart:async';
//
//import 'package:ProgrammingHero/src/database/contentdao.dart';
//import 'package:ProgrammingHero/src/models/chlng.dart';
//import 'package:ProgrammingHero/src/models/models.dart';
//import 'package:ProgrammingHero/src/models/superhero.dart';
//import 'package:ProgrammingHero/src/models/surprise_model.dart';
//import 'package:ProgrammingHero/src/models/user_models.dart';
//import 'package:ProgrammingHero/src/models/webProject_model.dart';
//
////This Repository class is the central point from where the data will flow to the ui.
//
//class Repository {
//  // Singleton instance
//  static final Repository _repo = new Repository._();
//
//  // Singleton accessor
//  static Repository get instance => _repo;
//
//  // A private constructor. Allows us to create instances of Repository
//  // only from within the Repository class itself.
//  Repository._();
//
//  //Home Data
//  Future<List<Home>> fetchAllHome() => dbLogic.getSeletedHomeData();
//  Future<int> getCurrentOpen() => dbLogic.getCurrentOpen();
//  Future<bool> checkModuleStatus(int id) => dbLogic.checkModuleStatus(id);
//}
