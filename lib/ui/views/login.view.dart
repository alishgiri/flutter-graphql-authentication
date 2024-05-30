import 'package:flutter/material.dart';

import 'package:auth_app/ui/shared/base.view.dart';
import 'package:auth_app/core/view_models/login.vm.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
      builder: (context, loginVm, child) {
        return Scaffold(
          key: loginVm.scaffoldKey,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Form(
                    // Attach form key for validations. I won't be adding validations.
                    // key: loginVm.formKey,
                    child: Column(
                      children: [
                        Text("Auth App", style: Theme.of(context).textTheme.displayMedium),
                        const SizedBox(height: 30),
                        TextFormField(
                          onChanged: loginVm.onChangedEmail,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(hintText: "Email"),
                        ),
                        const Divider(height: 2),
                        TextFormField(
                          obscureText: true,
                          onChanged: loginVm.onChangedPassword,
                          decoration: const InputDecoration(hintText: "Password"),
                        ),
                        const SizedBox(height: 20),
                        TextButton(
                          onPressed: loginVm.onLogin,
                          child: loginVm.isLoading ? const CircularProgressIndicator() : const Text("Login"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
