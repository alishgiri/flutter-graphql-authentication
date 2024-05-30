import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:auth_app/locator.dart';
import 'package:auth_app/ui/views/login.view.dart';
import 'package:auth_app/core/services/base.service.dart';
import 'package:auth_app/core/services/auth.service.dart';

void main() async {
  // If you want to use HiveStore() for GraphQL caching.
  // await initHiveForFlutter();

  setupLocator();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: locator<BaseService>().clientNotifier,
      child: ChangeNotifierProvider.value(
        value: locator<AuthService>(),
        child: const MaterialApp(
          title: 'your_app',
          debugShowCheckedModeBanner: false,
          home: LoginView(),
        ),
      ),
    );
  }
}
