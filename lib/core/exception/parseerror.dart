class ParseError {
  static String extractErrorMessage(dynamic error) {
    String cleaned = error.toString().replaceFirst('Exception:', '').trim();

    return loginError(cleaned);
  }

  static String loginError(String message) {
    if (message.contains(
      "{'non_field_errors': [ErrorDetail(string='Invalid credentials', code='invalid')]}",
    )) {
      return "Invalid credentials";
    }
    if (message.contains("status: User created")) {
      return "User created";
    }
    if (message.contains(
      "{'non_field_errors': [ErrorDetail(string='Account is not active. Please wait for admin verification.', code='invalid')]}",
    )) {
      return "Account is not active. Please wait for admin verification.";
    }
    if (message.contains(
      "message custom user with this national id already exists., Email already exists., Phone number already exists.",
    )) {
      return "User already exists with(this national id , email , phone number).";
    }
    if (message.contains(
      "message: Email already exists., Phone number already exists.",
    )) {
      return "User already exists with(this email , phone number).";
    }
    if (message.contains("message: Phone number already exists.")) {
      return "User already exists with(this phone number).";
    }
    if (message.contains("message: Email already exists.")) {
      return "User already exists with(this email).";
    }
    if (message.contains(
      "message: custom user with this national id already exists",
    )) {
      return "User already exists with(this national id).";
    }

    return message;
  }
}
