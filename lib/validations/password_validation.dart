bool isPasswordValid(String password) {
  final hasUppercase = RegExp(r'[A-Z]');
  final hasDigit = RegExp(r'[0-9]');
  final hasSpecialChar = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

  return hasUppercase.hasMatch(password) &&
      hasDigit.hasMatch(password) &&
      hasSpecialChar.hasMatch(password);
}

class PasswordValidation {
  static validatePassword(String password) {
    if (password.isEmpty) {
      return "This field is required";
    } else if (!isPasswordValid(password)) {
      return "Password must have one uppercase, digit and special character";
    } else {
      return null;
    }
  }
}
