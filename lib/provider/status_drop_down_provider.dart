import 'package:flutter/material.dart';

class StatusDropDownProvider extends ChangeNotifier {
  String defaultStatus = "Pending";

  void changeStatus(String changedStatus) {
    defaultStatus = changedStatus;
    notifyListeners();
  }
}
