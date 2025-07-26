class PasswordResetRequest {
  final String email;

  PasswordResetRequest(this.email);

  Map<String, dynamic> toJson() => {"email": email};
}

class VerifyOtpRequest {
  final String email;
  final String otp;

  VerifyOtpRequest(this.email, this.otp);

  Map<String, dynamic> toJson() => {"email": email, "otp": otp};
}

class SetNewPasswordRequest {
  final String email;
  final String otp;
  final String newPassword;

  SetNewPasswordRequest(this.email, this.otp, this.newPassword);

  Map<String, dynamic> toJson() => {
    "email": email,
    "otp": otp,
    "new_password": newPassword,
  };
}
