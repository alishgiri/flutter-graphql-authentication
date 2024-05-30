import 'package:auth_app/locator.dart';
import 'package:auth_app/core/view_models/base.vm.dart';
import 'package:auth_app/core/services/auth.service.dart';
import 'package:auth_app/graphql/__generated__/your_app.schema.graphql.dart';

class LoginViewModel extends BaseViewModel {
  String? _email;
  String? _password;

  // Used for validation or any other purpose like clearing form and more...
  // final formKey = GlobalKey<FormState>();

  final _authService = locator<AuthService>();

  void onChangedPassword(String value) => _password = value;

  void onChangedEmail(String value) => _email = value;

  Future<void> onLogin() async {
    // Validate login details using [formKey]
    // if (!formKey.currentState!.validate()) return;

    try {
      setIsLoading(true);
      final input = Input$LoginInput(identifier: _email!, password: _password!);
      await _authService.login(input);
      displaySnackBar("Successfully logged in!");
    } catch (error) {
      displaySnackBar(error.toString());
    } finally {
      setIsLoading(false);
    }
  }
}
