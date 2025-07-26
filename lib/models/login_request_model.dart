class LoginRequest {
  final String nationalId;
  final String password;

  LoginRequest({required this.nationalId, required this.password});

  Map<String, dynamic> toJson() => {
    "national_id": nationalId,
    "password": password,
  };
}
