import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class EmployeeImageProvider with ChangeNotifier {
  XFile? imagePath;
  void imageSelected(filepath) {
    imagePath = filepath;
    notifyListeners();
  }
}
