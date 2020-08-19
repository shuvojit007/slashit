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

  if (user["role"] != null) {
    locator<PrefManager>().role = user['role'];
    print("role ${user['role']}");

    if (user["role"] == "shopper") {
      var shopper = user["shopper"];
      if (shopper["availableBalance"] != null) {
        locator<PrefManager>().availableBalance = shopper["availableBalance"];
        print("availableBalance  ${shopper["availableBalance"]}");
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
  GraphQLConfiguration.setToken(token);
}

removeUser() {
  locator<PrefManager>().token = "null";
  locator<PrefManager>().email = "null";
  locator<PrefManager>().avatar = "null";
  locator<PrefManager>().name = "null";
  locator<PrefManager>().role = "null";
  GraphQLConfiguration.removeToken();

  print("remove user ${locator<PrefManager>().token}");
}
