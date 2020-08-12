import 'package:slashit/src/di/locator.dart';
import 'package:slashit/src/graphql/client.dart';
import 'package:slashit/src/utils/prefmanager.dart';

storeUser(data) {
  String token = data['token'];
  var user = data['user'];
  if (user["email"] != null) {
    locator<PrefManager>().email = data['email'];
    print("email ${data['email']}");
  }

  if (user["role"] != null) {
    locator<PrefManager>().role = user['role'];
    print("role ${user['role']}");
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
