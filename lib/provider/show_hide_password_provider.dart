import 'package:flutter/foundation.dart';

class ShowHidePasswordProvider with ChangeNotifier {
  bool isHiddenForLogin = true;
  bool isHiddenForSignup = true;
  void changeStatusForLogin() {
    isHiddenForLogin = !isHiddenForLogin;
    notifyListeners();
  }

  void changeStatusForSignup() {
    isHiddenForSignup = !isHiddenForSignup;
    notifyListeners();
  }
}
