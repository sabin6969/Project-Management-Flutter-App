import 'package:flutter/material.dart';

class DateSelectionProvider with ChangeNotifier {
  String selectedDate = DateTime.now().toString().substring(0, 10);

  void onSelectedNextDay(String newDate) {
    selectedDate = newDate;
    notifyListeners();
  }
}
