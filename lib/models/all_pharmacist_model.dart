class SinglePharmacy {
  final String fullName;
  final String phoneNumber;
  final String email;
  final String pharmacyName;
  final String pharmacyAddress;

  SinglePharmacy({
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.pharmacyName,
    required this.pharmacyAddress,
  });

  factory SinglePharmacy.fromJson(Map<String, dynamic> json) {
    return SinglePharmacy(
      fullName: json['full_name'],
      phoneNumber: json['phone_number'],
      email: json['email'],
      pharmacyName: json['pharmacy_name'],
      pharmacyAddress: json['pharmacy_address'],
    );
  }
}
