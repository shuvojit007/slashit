// Dart imports:
import 'dart:convert';

import 'package:dio/dio.dart';

class Service {
  static final Service _singleton = Service._();

  static Service get instance => _singleton;

  Service._();

  Future<String> getBankInformation() async {
    Response response;
    try {
      Dio dio = new Dio();
      response = await dio.get(
        "https://api.paystack.co/bank",
      );
      // print(response.toString());
    } catch (e) {
      print(e);
      return "Error";
    }

    return json.encode(response.data);
  }
}
