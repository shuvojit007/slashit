import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Config {
  static String _token;

  static final HttpLink httpLink = HttpLink(
    uri: 'http://13.228.27.185:4009/',
  );

  static final AuthLink authLink = AuthLink(getToken: () => _token);

//  static final WebSocketLink websocketLink = WebSocketLink(
//    url: 'wss://hasura.io/learn/graphql',
//    config: SocketClientConfig(
//      autoReconnect: true,
//      inactivityTimeout: Duration(seconds: 30),
//      initPayload: {
//        'headers': {'Authorization': _token},
//      },
//    ),
//  );

  static final Link link = httpLink;

  static ValueNotifier<GraphQLClient> initailizeClient() {
    //  _token = token;
    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
        link: link,
      ),
    );
    return client;
  }
}
