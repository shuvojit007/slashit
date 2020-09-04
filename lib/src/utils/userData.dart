import 'package:slashit/src/di/locator.dart';
import 'package:slashit/src/graphql/client.dart';
import 'package:slashit/src/utils/prefmanager.dart';

storeUser(data) {
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
        int speend = shopper["spendLimit"];
        locator<PrefManager>().spendLimit = shopper["spendLimit"];
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

removeUser() {
  locator<PrefManager>().token = "null";
  locator<PrefManager>().email = "null";
  locator<PrefManager>().avatar = "null";
  locator<PrefManager>().name = "null";
  locator<PrefManager>().role = "null";
  locator<PrefManager>().spendLimit = 0;
  GraphQLConfiguration.removeToken();

  print("remove user ${locator<PrefManager>().token}");
}
