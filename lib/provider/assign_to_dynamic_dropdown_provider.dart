import 'package:flutter/material.dart';

class AssignToDynamicDropDownProvider with ChangeNotifier {
  String? assignedUser;

  void selected(String selectedUser) {
    assignedUser = selectedUser;
    notifyListeners();
  }
}
