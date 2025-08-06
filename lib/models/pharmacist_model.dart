import 'dart:io';

import 'package:dio/dio.dart';

class PharmacistModel {
  final String fullName;
  final String email;
  final String nationalId;
  final String phoneNumber;
  final String? password;
  final String? gender;
  final String birthday;
  final String address;
  final String pharmacyName;
  final String pharmacyAddress;
  final File? faceIdImage;
  final File? backIdImage;
  final String userType;

  PharmacistModel({
    required this.fullName,
    required this.email,
    required this.nationalId,
    required this.phoneNumber,
    this.password,
    required this.gender,
    required this.birthday,
    required this.address,
    required this.pharmacyName,
    required this.pharmacyAddress,
    this.faceIdImage,
    this.backIdImage,
    this.userType = "pharmacist",
  });
  factory PharmacistModel.fromJson(Map<String, dynamic> json) =>
      PharmacistModel(
        fullName: json['full_name'],
        email: json['email'],
        nationalId: json['national_id'],
        phoneNumber: json['phone_number'],
        password: json['password'],
        gender: json['gender'],
        birthday: json['birthday'],
        address: json['address'],
        pharmacyName: json['pharmacy_name'],
        pharmacyAddress: json['pharmacy_address'],
        userType: json['user_type'],
      );
  FormData toFormData() {
    return FormData.fromMap({
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
      "face_id_image": MultipartFile.fromFileSync(
        faceIdImage!.path,
        filename: faceIdImage!.path.split('/').last,
      ),
      "back_id_image": MultipartFile.fromFileSync(
        backIdImage!.path,
        filename: backIdImage!.path.split('/').last,
      ),
    });
  }
}
