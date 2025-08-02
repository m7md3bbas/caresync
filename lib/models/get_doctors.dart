class GetDoctorModel {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String hospital;
  final String specialization;
  final String clinic;

  GetDoctorModel({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.hospital,
    required this.specialization,
    required this.clinic,
  });

  factory GetDoctorModel.fromJson(Map<String, dynamic> json) {
    return GetDoctorModel(
      fullName: json['full_name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      hospital: json['hospital'],
      specialization: json['specialization'],
      clinic: json['clinic'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'email': email,
      'phone_number': phoneNumber,
      'hospital': hospital,
      'specialization': specialization,
      'clinic': clinic,
    };
  }
}
