import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImageProvider with ChangeNotifier {
  XFile? imageFile;
  void onSelected(selectedFile) {
    imageFile = selectedFile;
    notifyListeners();
  }
}
