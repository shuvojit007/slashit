import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:slashit/src/di/locator.dart';
import 'package:slashit/src/service/client.dart';
import 'package:slashit/src/utils/routes.dart';

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await setupLocator();
    runApp(MyApp());
  } catch (error) {
    print('Locator setup has failed ${error.toString()}');
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
        client: Config.initailizeClient(),
        child: MaterialApp(
          title: 'Slashit',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          debugShowCheckedModeBanner: false,
          routes: Routes().route,
        ));
  }
}
