class GetPrescriptionModel {
  final String medicineName;
  final String dosage;
  final String instructions;
  final String createdAt;
  final String doctor;

  GetPrescriptionModel({
    required this.medicineName,
    required this.dosage,
    required this.instructions,
    required this.createdAt,
    required this.doctor,
  });

  factory GetPrescriptionModel.fromJson(Map<String, dynamic> json) {
    return GetPrescriptionModel(
      medicineName: json['medicine_name'],
      dosage: json['dosage'],
      instructions: json['instructions'],
      createdAt: json['created_at'],
      doctor: json['doctor'],
    );
  }
}

class GetPatientModel {
  final String fullName;
  final String nationalId;
  final String email;
  final String phoneNumber;
  final String birthday;
  final String address;
  final bool diabetes;
  final bool heartDisease;
  final List<String> allergies;
  final String otherDiseases;
  final List<GetPrescriptionModel> prescriptions;

  GetPatientModel({
    required this.fullName,
    required this.nationalId,
    required this.email,
    required this.phoneNumber,
    required this.birthday,
    required this.address,
    required this.diabetes,
    required this.heartDisease,
    required this.allergies,
    required this.otherDiseases,
    required this.prescriptions,
  });

  factory GetPatientModel.fromJson(Map<String, dynamic> json) {
    final prescriptionsJson = json['prescriptions'] as List;
    prescriptionsJson.sort((a, b) {
      final aDate = DateTime.parse(a['created_at']);
      final bDate = DateTime.parse(b['created_at']);
      return bDate.compareTo(aDate);
    });

    return GetPatientModel(
      fullName: json['full_name'],
      nationalId: json['national_id'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      birthday: json['birthday'],
      address: json['address'],
      diabetes: json['diabetes'],
      heartDisease: json['heart_disease'],
      allergies: List<String>.from(json['allergies']),
      otherDiseases: json['other_diseases'],
      prescriptions: prescriptionsJson
          .map((e) => GetPrescriptionModel.fromJson(e))
          .toList(),
    );
  }
}
