class CustomValidators {
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[^\w\s]).{8,}$',
  );

  static isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  static isValidPassword(String password) {
    if (password.isNotEmpty && _passwordRegExp.hasMatch(password)) {
      return true;
    }
    return false;
  }

  static isValidPasswordLogin(String password) {
    if (!password.isEmpty && password.length > 4) {
      return true;
    }
    return false;
  }
}
