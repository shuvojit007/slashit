import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:slashit/src/di/locator.dart';
import 'package:slashit/src/utils/prefmanager.dart';

class GraphQLConfiguration {
  static Link link = null;
  static HttpLink httpLink = HttpLink(
      // uri: 'http://13.228.27.185:4009/',
      uri: "https://slashapi.herokuapp.com/"
      //uri: "https://pm-gateway.herokuapp.com/",
      );

  static final WebSocketLink websocketLink = WebSocketLink(
    // url: "wss://pm-gateway.herokuapp.com/graphql",
    url: "wss://slashapi.herokuapp.com/",

    config: SocketClientConfig(
      autoReconnect: true,
      inactivityTimeout: Duration(seconds: 30),
    ),
  );

  static void setToken(String token) {
    print("setToken $token");
    print("role ${locator<PrefManager>().role}");
    AuthLink alink = AuthLink(getToken: () async => token);
    if (locator<PrefManager>().role == "shopper") {
      GraphQLConfiguration.link =
          alink.concat(GraphQLConfiguration.httpLink).concat(websocketLink);
    } else {
      GraphQLConfiguration.link = alink.concat(GraphQLConfiguration.httpLink);
    }
  }

  static void removeToken() {
    GraphQLConfiguration.link = null;
  }

  static Link getLink() {
    return GraphQLConfiguration.link != null
        ? GraphQLConfiguration.link
        : GraphQLConfiguration.httpLink;
  }

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: getLink(),
      cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
    ),
  );

  GraphQLClient clientToQuery() {
    return GraphQLClient(
      cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
      link: getLink(),
    );
  }
}
