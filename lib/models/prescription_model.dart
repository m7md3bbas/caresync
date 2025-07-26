class PrescriptionModel {
  final String medicineName;
  final String dosage;
  final String instructions;

  PrescriptionModel({
    required this.medicineName,
    required this.dosage,
    required this.instructions,
  });

  Map<String, dynamic> toJson() => {
    "medicine_name": medicineName,
    "dosage": dosage,
    "instructions": instructions,
  };
}
