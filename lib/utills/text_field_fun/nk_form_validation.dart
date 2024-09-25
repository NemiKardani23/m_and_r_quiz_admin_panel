class NkFormValidation {
  static String? emailValidation(dynamic email) {
    if (email == null && email.isEmpty == true) {
      return "Email is required";
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      return "Enter a valid email";
    }
    return null;
  }
}
