class PatientModel {
  final String fullName;
  final String email;
  final String nationalId;
  final String phoneNumber;
  final String password;
  final String? gender;
  final String birthday;
  final String address;
  final bool diabetes;
  final bool heartDisease;
  final List<String> allergies;
  final String otherDiseases;
  final String userType;

  PatientModel({
    required this.fullName,
    required this.email,
    required this.nationalId,
    required this.phoneNumber,
    required this.password,
    required this.gender,
    required this.birthday,
    required this.address,
    required this.diabetes,
    required this.heartDisease,
    required this.allergies,
    required this.otherDiseases,
    this.userType = "patient",
  });

  Map<String, dynamic> toJson() {
    return {
      "full_name": fullName,
      "email": email,
      "national_id": nationalId,
      "phone_number": phoneNumber,
      "password": password,
      "gender": gender,
      "birthday": birthday,
      "address": address,
      "diabetes": diabetes,
      "heart_disease": heartDisease,
      "allergies": allergies,
      "other_diseases": otherDiseases,
      "user_type": userType,
    };
  }
}
