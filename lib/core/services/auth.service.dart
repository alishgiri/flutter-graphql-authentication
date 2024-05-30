import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:auth_app/locator.dart';
import 'package:auth_app/core/models/auth.model.dart';
import 'package:auth_app/core/services/base.service.dart';
import 'package:auth_app/core/services/secure_storage.service.dart';
import 'package:auth_app/graphql/queries/__generated__/auth.graphql.dart';
import 'package:auth_app/graphql/__generated__/your_app.schema.graphql.dart';

class AuthService extends ChangeNotifier {
  Auth? _auth;
  final client = locator<BaseService>().client;
  final storageService = locator<SecureStorageService>();

  Auth? get auth => _auth;

  Future<void> initAuthIfPreviouslyLoggedIn() async {
    final auth = await storageService.getAuthData();
    if (auth.accessToken != null) {
      _auth = Auth.fromAuthData(auth);
      notifyListeners();
    }
  }

  Future<void> login(Input$LoginInput input) async {
    final result = await client.query$Login(Options$Query$Login(
      variables: Variables$Query$Login(input: input),
    ));

    final resp = result.parsedData?.auth.login;
    print(resp?.accessToken);

    if (resp is Fragment$LoginSuccess) {
      _auth = Auth.fromJson(resp.toJson());
      storageService.storeAuthData(_auth!);
      notifyListeners();
    } else {
      throw gqlErrorHandler(result.exception);
    }
  }

  Future<void> registerUser(Input$UserInput input) async {
    final result = await client.mutate$RegisterUser(Options$Mutation$RegisterUser(
      variables: Variables$Mutation$RegisterUser(input: input),
    ));

    final resp = result.parsedData?.auth.register;

    if (resp is! Fragment$RegisterSuccess) {
      throw gqlErrorHandler(result.exception);
    }
  }

  Future<void> logout() async {
    await locator<SecureStorageService>().clearAuthData();
    _auth = null;
    notifyListeners();
  }

  // You can put this in a common utility functions so
  // that you can reuse it in other services file too.
  //
  String gqlErrorHandler(OperationException? exception) {
    if (exception != null && exception.graphqlErrors.isNotEmpty) {
      return exception.graphqlErrors.first.message;
    }
    return "Something went wrong.";
  }
}
