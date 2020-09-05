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
        return true;
      } else {
        showToastMsg(map['message']);
        return false;
      }
    }
  }

  Future<bool> registerUser(Map<String, String> userInput) async {
    GraphQLClient _client = GraphQLConfiguration().clientToQuery();
    QueryResult result = await _client.mutate(MutationOptions(
        documentNode: gql(
      GraphApi.instance.register(userInput),
    )));
    if (result.hasException) {
      showToastMsg("Something went wrong");
      return false;
    } else {
      LazyCacheMap map = result.data.get("Register");
      if (map['success'] == true) {
        showToastMsg("User created successfully. Please verify your email");
        return true;
      } else {
        showToastMsg(map['message']);
        return false;
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

  Future<Features> feachFeatures(int limit, int offset) async {
    GraphQLClient _client = GraphQLConfiguration().clientToQuery();
    QueryResult result = await _client.query(QueryOptions(
        documentNode: gql(
      GraphApi.instance.feachFeature(limit, offset),
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

  Future<TransactionsModel> fetchTransactions(int limit, int offset) async {
    GraphQLClient _client = GraphQLConfiguration().clientToQuery();
    QueryResult result = await _client.query(QueryOptions(
        documentNode: gql(
      GraphApi.instance.fetchTransactions(limit, offset),
    )));
    if (result.hasException) {
      print("error  ${result.exception.toString()}");
      return null;
    } else {
      LazyCacheMap map = result.data.get("FetchTransaction");
      if (map['success'] == true) {
        print(json.encode(result.data.get("FetchTransaction")));
        TransactionsModel transaction =
            transactionsModelFromMap(json.encode(map));
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

  Future<bool> payNow(
    String id,
  ) async {
    try {
      GraphQLClient _client = GraphQLConfiguration().clientToQuery();
      QueryResult result = await _client.mutate(MutationOptions(
          documentNode: gql(
        GraphApi.instance.payNow(id),
      )));
      if (result.hasException) {
        showToastMsg(result.exception.toString());
        return false;
      } else {
        LazyCacheMap map = result.data.get("Paynow");
        if (map['success'] == true && map['code'] == "OK") {
          showToastMsgGreen(map['message']);
          return true;
        } else {
          showToastMsg(map['message']);
          return false;
        }
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> payLateFee(
    String id,
  ) async {
    try {
      GraphQLClient _client = GraphQLConfiguration().clientToQuery();
      QueryResult result = await _client.mutate(MutationOptions(
          documentNode: gql(
        GraphApi.instance.payLateFee(id),
      )));
      if (result.hasException) {
        showToastMsg(result.exception.toString());
        return false;
      } else {
        LazyCacheMap map = result.data.get("PayLateFee");
        if (map['success'] == true) {
          showToastMsgGreen(map['message']);
          return true;
        } else {
          showToastMsg(map['message']);
          return false;
        }
      }
    } catch (e) {
      return false;
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
          showToastMsg(map['message']);
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
          showToastMsgGreen("Wallet has been completed");
          return true;
        } else {
          showToastMsg(map['message']);
          return false;
        }
      }
    } catch (e) {
      return false;
    }
  }

  //============business ========/
  Future<PaymentReq> fetchPaymentReq(int limit, int offset) async {
    GraphQLClient _client = GraphQLConfiguration().clientToQuery();
    QueryResult result = await _client.query(QueryOptions(
        documentNode: gql(
      GraphApi.instance.fetchPaymentreq(limit, offset),
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

  Future<PaymentReq> fetchPaymentReqShopper() async {
    GraphQLClient _client = GraphQLConfiguration().clientToQuery();
    QueryResult result = await _client.query(QueryOptions(
        documentNode: gql(
      GraphApi.instance.fetchPaymentreqShopper(),
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

  Future<int> fetchPaymentReqCount() async {
    GraphQLClient _client = GraphQLConfiguration().clientToQuery();
    QueryResult result = await _client.query(QueryOptions(
        documentNode: gql(
      GraphApi.instance.fetchPaymentreqCount(),
    )));
    if (result.hasException) {
      print("error  ${result.exception.toString()}");
      return 0;
    } else {
      LazyCacheMap map = result.data.get("FetchPaymentReq");
      if (map['success'] == true) {
        return map['count'];
      } else {
        print("Something went wrong");
        return 0;
      }
    }
  }

  Future<bool> createPaymentReq(
    dynamic paymentInput,
    dynamic paymentMethod,
  ) async {
    try {
      GraphQLClient _client = GraphQLConfiguration().clientToQuery();
      QueryResult result = await _client.mutate(MutationOptions(
          documentNode: gql(
        GraphApi.instance.createPaymentReq(paymentInput, paymentMethod),
      )));
      if (result.hasException) {
        showToastMsg("Something went wrong");
        return false;
      } else {
        LazyCacheMap map = result.data.get("CreatePaymentReq");
        if (map['success'] == true) {
          showToastMsgGreen(map['message']);
          print(map['orderId']);
          return true;
        } else {
          showToastMsgGreen(map['message']);
          return false;
        }
      }
    } catch (e) {
      return false;
    }
  }

  Future<String> createPaymentReqCopy(
    dynamic paymentInput,
    dynamic paymentMethod,
  ) async {
    try {
      GraphQLClient _client = GraphQLConfiguration().clientToQuery();
      QueryResult result = await _client.mutate(MutationOptions(
          documentNode: gql(
        GraphApi.instance.createPaymentReq(paymentInput, paymentMethod),
      )));
      if (result.hasException) {
        showToastMsg("Something went wrong");
        return null;
      } else {
        LazyCacheMap map = result.data.get("CreatePaymentReq");
        if (map['success'] == true) {
          showToastMsgGreen(map['message']);
          return map['orderId'];
        } else {
          showToastMsgGreen(map['message']);
          return null;
        }
      }
    } catch (e) {
      return null;
    }
  }

  Future<bool> createPaymentReqByShopper(
      String title, int amount, String type, String uniqueId) async {
    try {
      GraphQLClient _client = GraphQLConfiguration().clientToQuery();
      QueryResult result = await _client.mutate(MutationOptions(
          documentNode: gql(
        GraphApi.instance
            .createPaymentReqByShopper(title, amount, type, uniqueId),
      )));
      if (result.hasException) {
        showToastMsg("Something went wrong");
        return false;
      } else {
        LazyCacheMap map = result.data.get("CreatePaymentReqByShopper");
        if (map['success'] == true) {
          showToastMsgGreen(map['message']);
          print(map['orderId']);
          return true;
        } else {
          showToastMsgGreen(map['message']);
          return false;
        }
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> acceptPaymentReq(
    String orderId,
  ) async {
    try {
      GraphQLClient _client = GraphQLConfiguration().clientToQuery();
      QueryResult result = await _client.mutate(MutationOptions(
          documentNode: gql(
        GraphApi.instance.acceptPaymentReq(orderId),
      )));
      if (result.hasException) {
        showToastMsg("Something went wrong");
        return false;
      } else {
        LazyCacheMap map = result.data.get("AcceptPaymentReq");
        if (map['success'] == true) {
          showToastMsgGreen(map['message']);
          return true;
        } else {
          showToastMsg(map['message']);
          return false;
        }
      }
    } catch (e) {
      return false;
    }
  }

  Future<String> accountHolderName(
    String bankCode,
    String accountNumber,
  ) async {
    try {
      GraphQLClient _client = GraphQLConfiguration().clientToQuery();
      QueryResult result = await _client.mutate(
        MutationOptions(
          documentNode: gql(
            GraphApi.instance.resolveBankAccount(bankCode, accountNumber),
          ),
        ),
      );
      if (result.hasException) {
        return null;
      } else {
        LazyCacheMap map = result.data.get("ResolveBankAccount");
        if (map['success'] == true) {
          return map['accountHolderName'];
        } else {
          return null;
        }
      }
    } catch (e) {
      return null;
    }
  }

  Future<bool> rejectPaymentReq(
    String orderId,
  ) async {
    try {
      GraphQLClient _client = GraphQLConfiguration().clientToQuery();
      QueryResult result = await _client.mutate(MutationOptions(
          documentNode: gql(
        GraphApi.instance.rejectPaymentReq(orderId),
      )));
      if (result.hasException) {
        showToastMsg("Something went wrong");
        return false;
      } else {
        LazyCacheMap map = result.data.get("RejectPaymentReq");
        if (map['success'] == true) {
          showToastMsgGreen(map['message']);
          return true;
        } else {
          showToastMsg(map['message']);
          return false;
        }
      }
    } catch (e) {
      return false;
    }
  }

  //===========BANK================//
  Future<bool> withdrawBalance(
      int amount, String accountNumber, String bankCode) async {
    try {
      GraphQLClient _client = GraphQLConfiguration().clientToQuery();
      QueryResult result = await _client.mutate(MutationOptions(
          documentNode: gql(
        GraphApi.instance.withDrawBalance(amount, accountNumber, bankCode),
      )));
      if (result.hasException) {
        showToastMsg("Something went wrong");
        return false;
      } else {
        LazyCacheMap map = result.data.get("WithdrawBalance");
        if (map['success'] == true) {
          showToastMsgGreen(map['message']);
          return true;
        } else {
          showToastMsg(map['message']);
          return false;
        }
      }
    } catch (e) {
      return false;
    }
  }

  Future<String> uploadImage(dynamic file) async {
    try {
      GraphQLClient _client = GraphQLConfiguration().clientToQuery();
      QueryResult result = await _client.mutate(MutationOptions(
          documentNode: gql(GraphApi.instance.uploadImage()),
          variables: {"file": file}));
      if (result.hasException) {
        showToastMsg("Something went wrong");
        print(result.exception.toString());
        return null;
      } else {
        LazyCacheMap map = result.data.get("SingleUpload");
        if (map['imageLink'] != "") {
          return map['imageLink'];
        } else {
          return "Something went wrong";
        }
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //===============Subscription===========//
  Future<Stream> paymentSubscriptions(
    String id,
  ) async {
    try {
      GraphQLClient _client = GraphQLConfiguration().clientToQuery();
      return await GraphQLConfiguration().clientToQuery().subscribe(Operation(
              documentNode: gql(
            GraphApi.instance.paymentSubscription(id),
          )));

//      if (result.hasException) {
//        showToastMsg("Something went wrong");
//        return false;
//      } else {
//        LazyCacheMap map = result.data.get("RechargeWallet");
//        if (map['success'] == true) {
//          showToastMsgGreen("Wallet has been completed");
//          return true;
//        } else {
//          showToastMsg(map['message']);
//          return false;
//        }
//      }
    } catch (e) {
      return null;
    }
  }
}
