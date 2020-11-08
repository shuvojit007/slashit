import 'dart:convert';

import 'package:flutter_session/flutter_session.dart';
import 'package:slashit/src/database/dao.dart';
import 'package:slashit/src/di/locator.dart';
import 'package:slashit/src/graphql/client.dart';
import 'package:slashit/src/models/serviceFee.dart';
import 'package:slashit/src/utils/prefmanager.dart';

storeUser(data) async {
  String token = data['token'];
  var user = data['user'];
  if (user["email"] != null) {
    locator<PrefManager>().email = user['email'];
    print("email ${user['email']}");
  }

  if (user["_id"] != null) {
    locator<PrefManager>().userID = user['_id'];
    print("_id ${user['_id']}");
  }

  if (user["uniqueId"] != null) {
    locator<PrefManager>().uniqueId = user['uniqueId'];
    print("uniqueId ${user['uniqueId']}");
  }

  if (user["role"] != null) {
    locator<PrefManager>().role = user['role'];

    if (user["role"] == "shopper") {
      var shopper = user["shopper"];
      if (shopper["availableBalance"] != null) {
        locator<PrefManager>().availableBalance = shopper["availableBalance"];
      }
      if (shopper["spendLimit"] != null) {
        locator<PrefManager>().spendLimit = shopper["spendLimit"];
      }

      //=====service fee =====//
      if (data["serviceFee"] != null) {
        List<ServiceFee> serviceFee =
            serviceFeeFromMap(json.encode(data["serviceFee"]));

        serviceFee.forEach((element) async {
          print("service fee ${element.toString()}");
          await dbLogic.addService(element);
        });
      }

      //=====billing address=====//
      if (shopper["billing"] != null) {
        var billing = shopper["billing"];
        if (billing["address"] != null) {
          locator<PrefManager>().address = billing["address"];
        }
        if (billing["city"] != null) {
          locator<PrefManager>().city = billing["city"];
        }
        if (billing["state"] != null) {
          locator<PrefManager>().state = billing["state"];
        }
        if (billing["postalCode"] != null) {
          locator<PrefManager>().postalcode = billing["postalCode"];
        }
        if (billing["country"] != null) {
          locator<PrefManager>().country = billing["country"];
        }
      }
    } else {
      var business = user["business"];
      if (business["availableBalance"] != null) {
        locator<PrefManager>().availableBalance = business["availableBalance"];
      }
    }
  }

  if (user["firstname"] != null && user["lastname"] != null) {
    locator<PrefManager>().name = " ${user["firstname"]} ${user["lastname"]}";
    print("firstname ${user['firstname']}");
    print("lastname ${user['lastname']}");
  }

  if (user["avater"] != null) {
    locator<PrefManager>().avatar = user['avater'];
    print("avatar ${user['avater']}");
  }
  print("token ${data['token']}");

  locator<PrefManager>().token = token;
  locator<PrefManager>().tokenTimeStamp = DateTime.now().millisecondsSinceEpoch;
  await FlutterSession().set("token", 'Bearer ' + token);
  GraphQLConfiguration.setToken(
    token,
  );
}

updateUser(data) {
  var user = data['user'];
  if (user["email"] != null) {
    locator<PrefManager>().email = user['email'];
    print("email ${user['email']}");
  }

  if (user["role"] != null) {
    locator<PrefManager>().role = user['role'];
    print("role ${user['role']}");

    if (user["role"] == "shopper") {
      var shopper = user["shopper"];
      if (shopper["availableBalance"] != null) {
        locator<PrefManager>().availableBalance = shopper["availableBalance"];
        print("availableBalance  ${shopper["availableBalance"]}");
      }

      if (shopper["spendLimit"] != null) {
        locator<PrefManager>().spendLimit = shopper["spendLimit"];
        print("spendLimit  ${shopper["spendLimit"]}");
      }
    } else {
      var business = user["business"];
      if (business["availableBalance"] != null) {
        locator<PrefManager>().availableBalance = business["availableBalance"];
        print("availableBalance  ${business["availableBalance"]}");
      }
    }
  }

  if (user["firstname"] != null && user["lastname"] != null) {
    locator<PrefManager>().name = " ${user["firstname"]} ${user["lastname"]}";
    print("firstname ${user['firstname']}");
    print("lastname ${user['lastname']}");
  }

  if (user["avater"] != null) {
    locator<PrefManager>().avatar = user['avater'];
    print("avatar ${user['avater']}");
  }
}

removeUser() async {
  locator<PrefManager>().token = "null";
  locator<PrefManager>().email = "null";
  locator<PrefManager>().avatar = "null";
  locator<PrefManager>().name = "null";
  locator<PrefManager>().role = "null";
  locator<PrefManager>().spendLimit = 0;
  //shopper billing address
  locator<PrefManager>().address = "null";
  locator<PrefManager>().city = "null";
  locator<PrefManager>().state = "null";
  locator<PrefManager>().postalcode = "null";
  locator<PrefManager>().country = "null";

  GraphQLConfiguration.removeToken();
  await dbLogic.deleteAll();
  print("remove user ${locator<PrefManager>().token}");
}
