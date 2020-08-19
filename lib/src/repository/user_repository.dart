// Dart imports:
import 'dart:async';
import 'dart:convert';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:slashit/src/graphql/client.dart';
import 'package:slashit/src/graphql/graph_api.dart';
import 'package:slashit/src/models/features_model.dart';
import 'package:slashit/src/models/transaction.dart';
import 'package:slashit/src/models/upcommingPayments.dart';
import 'package:slashit/src/utils/showToast.dart';
import 'package:slashit/src/utils/userData.dart';

class UserRepository {
  static final UserRepository _singleton = UserRepository._();

  static UserRepository get instance => _singleton;

  UserRepository._() {}

  Future<bool> authUser(String email, String password, bool isBusiness) async {
    GraphQLClient _client = GraphQLConfiguration().clientToQuery();
    QueryResult result = await _client.mutate(MutationOptions(
        documentNode: gql(
      GraphApi.instance.login(email, password, isBusiness),
    )));
    if (result.hasException) {
      print("error  ${result.exception.toString()}");
      showToastMsg("Something went wrong");
      return false;
    } else {
      LazyCacheMap map = result.data.get("Login");
      if (map['success'] == true) {
        storeUser(result.data['Login']);
        showToastMsgGreen("Login succesfull");
        return true;
      } else {
        print("Something went wrong");
        showToastMsg("Something went wrong");
        return false;
      }
    }
  }

  Future registerUser(Map<String, String> userInput) async {
    GraphQLClient _client = GraphQLConfiguration().clientToQuery();
    QueryResult result = await _client.mutate(MutationOptions(
        documentNode: gql(
      GraphApi.instance.register(userInput),
    )));
    if (result.hasException) {
      showToastMsg("Something went wrong");
    } else {
      LazyCacheMap map = result.data.get("Register");

      map.forEach((key, value) {
        print("key $key  value $value");
      });
      print("result $result");
      if (map['success'] == true) {
        showToastMsgGreen(
            "User created successfully. Please verify your email");
      } else {
        showToastMsg("Something went wrong");
      }
    }
  }

  Future<bool> forgetPass(String email) async {
    GraphQLClient _client = GraphQLConfiguration().clientToQuery();
    QueryResult result = await _client.mutate(MutationOptions(
        documentNode: gql(
      GraphApi.instance.forgetPassword(email),
    )));
    if (result.hasException) {
      showToastMsg("Something went wrong");
      return false;
    } else {
      LazyCacheMap map = result.data.get("ForgetPassword");
      map.forEach((key, value) {
        print("key $key  value $value");
      });
      print("result $result");
      if (map['success'] == true) {
        showToastMsgGreen("Please check email for further instruction.");
        return true;
      } else {
        showToastMsg("Something went wrong");
        return false;
      }
    }
  }

  Future<Features> feachFeatures() async {
    GraphQLClient _client = GraphQLConfiguration().clientToQuery();
    QueryResult result = await _client.query(QueryOptions(
        documentNode: gql(
      GraphApi.instance.feachFeature(),
    )));
    if (result.hasException) {
      print("error  ${result.exception.toString()}");
      return null;
    } else {
      LazyCacheMap map = result.data.get("FetchFeature");
      if (map['success'] == true) {
        Features features = featuresFromMap(json.encode(map));
        return features;
      } else {
        print("Something went wrong");
        return null;
      }
    }
  }

  Future<bool> addCard(
    String reference,
  ) async {
    GraphQLClient _client = GraphQLConfiguration().clientToQuery();
    QueryResult result = await _client.mutate(MutationOptions(
        documentNode: gql(
      GraphApi.instance.addCard(reference),
    )));
    if (result.hasException) {
      showToastMsg("Something went wrong");
      return false;
    } else {
      LazyCacheMap map = result.data.get("AddCard");
      if (map['success'] == true && map['code'] == "ADDED") {
        showToastMsgGreen("Card successfully added");
        return true;
      } else {
        showToastMsg("Something went wrong");
        return false;
      }
    }
  }

  Future<UpcommingPayments> upCommingRepayments() async {
    GraphQLClient _client = GraphQLConfiguration().clientToQuery();
    QueryResult result = await _client.query(QueryOptions(
        documentNode: gql(
      GraphApi.instance.upcomingPayments(),
    )));
    if (result.hasException) {
      print("error  ${result.exception.toString()}");
      return null;
    } else {
      LazyCacheMap map = result.data.get("FetchOrder");
      if (map['success'] == true) {
        UpcommingPayments upPayments =
            upcommingPaymentsFromMap(json.encode(map));
        return upPayments;
      } else {
        print("Something went wrong");
        return null;
      }
    }
  }

  Future<Transactions> fetchTransactions() async {
    GraphQLClient _client = GraphQLConfiguration().clientToQuery();
    QueryResult result = await _client.query(QueryOptions(
        documentNode: gql(
      GraphApi.instance.fetchTransactions(),
    )));
    if (result.hasException) {
      print("error  ${result.exception.toString()}");
      return null;
    } else {
      LazyCacheMap map = result.data.get("FetchTransaction");
      if (map['success'] == true) {
        Transactions transaction = transactionsFromMap(json.encode(map));
        print(transaction.toString());
        return transaction;
      } else {
        print("Something went wrong");
        return null;
      }
    }
  }

  _getErrorMessage(error) {
    String errorMessage = "Something went wrong";
    switch (error.code) {
      case "ERROR_INVALID_EMAIL":
        errorMessage = "Your email address appears to be malformed.";
        break;
      case "ERROR_WRONG_PASSWORD":
        errorMessage = "Your password is wrong.";
        break;
      case "ERROR_USER_NOT_FOUND":
        errorMessage = "User with this email doesn't exist.";
        break;
      case "ERROR_USER_DISABLED":
        errorMessage = "User with this email has been disabled.";
        break;
      case "ERROR_TOO_MANY_REQUESTS":
        errorMessage = "Too many requests. Try again later.";
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
        errorMessage = "Signing in with Email and Password is not enabled.";
        break;
      default:
        errorMessage = "An undefined Error happened.";
    }

    return errorMessage;
  }
}
