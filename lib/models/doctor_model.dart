class DoctorModel {
  final String fullName;
  final String email;
  final String nationalId;
  final String phoneNumber;
  final String? password;
  final String? gender;
  final String birthday;
  final String address;
  final String hospital;
  final String clinic;
  final String specialization;
  final String userType;

  DoctorModel({
    required this.fullName,
    required this.email,
    required this.nationalId,
    required this.phoneNumber,
    this.password,
    required this.gender,
    required this.birthday,
    required this.address,
    required this.hospital,
    required this.clinic,
    required this.specialization,
    this.userType = "doctor",
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      fullName: json['full_name'],
      email: json['email'],
      nationalId: json['national_id'],
      phoneNumber: json['phone_number'],
      gender: json['gender'],
      birthday: json['birthday'],
      address: json['address'],
      hospital: json['hospital'],
      clinic: json['clinic'],
      specialization: json['specialization'],
      userType: json['user_type'],
    );
  }

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
      "hospital": hospital,
      "clinic": clinic,
      "specialization": specialization,
      "user_type": userType,
    };
  }
}
