// Dart imports:
import 'dart:async';
import 'dart:convert';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:slashit/src/graphql/client.dart';
import 'package:slashit/src/graphql/graph_api.dart';
import 'package:slashit/src/models/cards.dart';
import 'package:slashit/src/models/features_model.dart';
import 'package:slashit/src/models/paymentReq.dart';
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

  Future<TransactionsModel> fetchTransactions(int limit) async {
    GraphQLClient _client = GraphQLConfiguration().clientToQuery();
    QueryResult result = await _client.query(QueryOptions(
        documentNode: gql(
      GraphApi.instance.fetchTransactions(limit),
    )));
    if (result.hasException) {
      print("error  ${result.exception.toString()}");
      return null;
    } else {
      LazyCacheMap map = result.data.get("FetchTransaction");
      if (map['success'] == true) {
        print(json.encode(result.data.get("FetchTransaction")));
        TransactionsModel transaction = transactionsFromMap(json.encode(map));
        print(transaction.toString());
        return transaction;
      } else {
        print("Something went wrong");
        return null;
      }
    }
  }

  Future<void> fetchUser() async {
    GraphQLClient _client = GraphQLConfiguration().clientToQuery();
    QueryResult result = await _client.query(QueryOptions(
        documentNode: gql(
      GraphApi.instance.fetchUser(),
    )));
    if (result.hasException) {
      print("error  ${result.exception.toString()}");
    } else {
      LazyCacheMap map = result.data.get("FetchUserById");
      if (map['success'] == true) {
        updateUser(result.data['FetchUserById']);
      } else {
        print("Something went wrong");
      }
    }
  }

  //============Cards =============//
  Future<Cards> fetchCards() async {
    GraphQLClient _client = GraphQLConfiguration().clientToQuery();
    QueryResult result = await _client.query(QueryOptions(
        documentNode: gql(
      GraphApi.instance.fetchCards(),
    )));
    if (result.hasException) {
      print("error  ${result.exception.toString()}");
      return null;
    } else {
      LazyCacheMap map = result.data.get("FetchCard");
      if (map['code'] == "OK") {
        Cards cards = cardsFromMap(json.encode(map));
        print(cards.toString());
        return cards;
      } else {
        print("Something went wrong");
        return null;
      }
    }
  }

  Future<bool> addCard(
    String reference,
  ) async {
    try {
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
    } catch (e) {
      return false;
    }
  }

  Future<bool> setPrefferdCard(
    String id,
  ) async {
    try {
      GraphQLClient _client = GraphQLConfiguration().clientToQuery();
      QueryResult result = await _client.mutate(MutationOptions(
          documentNode: gql(
        GraphApi.instance.setPrefferdCard(id),
      )));
      if (result.hasException) {
        showToastMsg("Something went wrong");
        return false;
      } else {
        LazyCacheMap map = result.data.get("SetPreferredCard");
        if (map['success'] == true) {
          return true;
        } else {
          showToastMsg("Something went wrong");
          return false;
        }
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteCard(
    String id,
  ) async {
    try {
      GraphQLClient _client = GraphQLConfiguration().clientToQuery();
      QueryResult result = await _client.mutate(MutationOptions(
          documentNode: gql(
        GraphApi.instance.deleteCard(id),
      )));
      if (result.hasException) {
        showToastMsg("Something went wrong");
        return false;
      } else {
        LazyCacheMap map = result.data.get("DeleteCard");
        if (map['success'] == true) {
          return true;
        } else {
          showToastMsg("Something went wrong");
          return false;
        }
      }
    } catch (e) {
      return false;
    }
  }

//============Add Money =============//

  Future<bool> addMony(
    double money,
  ) async {
    try {
      GraphQLClient _client = GraphQLConfiguration().clientToQuery();
      QueryResult result = await _client.mutate(MutationOptions(
          documentNode: gql(
        GraphApi.instance.addMony(money),
      )));
      if (result.hasException) {
        showToastMsg("Something went wrong");
        return false;
      } else {
        LazyCacheMap map = result.data.get("RechargeWallet");
        if (map['success'] == true) {
          showToastMsgGreen(map['message']);
          return true;
        } else {
          showToastMsg("Something went wrong");
          return false;
        }
      }
    } catch (e) {
      return false;
    }
  }

  //============business ========/
  Future<PaymentReq> fetchPaymentReq() async {
    GraphQLClient _client = GraphQLConfiguration().clientToQuery();
    QueryResult result = await _client.query(QueryOptions(
        documentNode: gql(
      GraphApi.instance.fetchPaymentreq(),
    )));
    if (result.hasException) {
      print("error  ${result.exception.toString()}");
      return null;
    } else {
      LazyCacheMap map = result.data.get("FetchPaymentReq");
      if (map['success'] == true) {
        PaymentReq paymentReq = paymentReqFromMap(json.encode(map));
        print(paymentReq.toString());
        return paymentReq;
      } else {
        print("Something went wrong");
        return null;
      }
    }
  }
}
