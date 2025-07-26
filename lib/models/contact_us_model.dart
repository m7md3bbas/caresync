class ContactUsModel {
  final String name;
  final String nationalId;
  final String message;

  ContactUsModel({
    required this.name,
    required this.nationalId,
    required this.message,
  });

  Map<String, dynamic> toJson() => {
    "name": name,
    "national_id": nationalId,
    "message": message,
  };
}
