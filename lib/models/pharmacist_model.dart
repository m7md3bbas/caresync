class PharmacistModel {
  final String fullName;
  final String email;
  final String nationalId;
  final String phoneNumber;
  final String password;
  final String? gender;
  final String birthday;
  final String address;
  final String pharmacyName;
  final String pharmacyAddress;
  final String userType;

  PharmacistModel({
    required this.fullName,
    required this.email,
    required this.nationalId,
    required this.phoneNumber,
    required this.password,
    required this.gender,
    required this.birthday,
    required this.address,
    required this.pharmacyName,
    required this.pharmacyAddress,
    this.userType = "pharmacist",
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
      "pharmacy_name": pharmacyName,
      "pharmacy_address": pharmacyAddress,
      "user_type": userType,
    };
  }
}
