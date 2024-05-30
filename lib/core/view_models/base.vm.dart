import 'package:flutter/material.dart';

class BaseViewModel extends ChangeNotifier {
  bool _isLoading = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool get isLoading => _isLoading;

  setIsLoading([bool busy = true]) {
    _isLoading = busy;
    notifyListeners();
  }

  void displaySnackBar(String message) {
    final scaffoldMessenger = ScaffoldMessenger.of(
      scaffoldKey.currentContext!,
    );

    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.warning, color: Colors.white),
            const SizedBox(width: 10),
            Flexible(child: Text(message)),
          ],
        ),
      ),
    );
  }
}
