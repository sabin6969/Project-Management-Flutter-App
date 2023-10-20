import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projectmanagementapp/controller/auth_controller.dart';

FirebaseFirestore dbRefrence = FirebaseFirestore.instance;

class AddUserController {
  static addUser(String name, String designation, String email, imageFile) {
    dbRefrence.collection(auth.currentUser!.uid).doc("$name'sdetails").set({
      "name": name,
      "email": email,
      "designation": designation,
    });
  }
}
