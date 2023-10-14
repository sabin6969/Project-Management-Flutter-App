bool isEmailValid(String email) {
  final emailRegExp =
      RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
  return emailRegExp.hasMatch(email);
}

class EmailValidation {
  static validateEmail(String email) {
    if (email.isEmpty) {
      return "This field is requrired";
    } else if (!isEmailValid(email)) {
      return "Enter a valid mail";
    } else {
      return null;
    }
  }
}
