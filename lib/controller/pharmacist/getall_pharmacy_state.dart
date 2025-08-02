import 'package:caresync/models/all_pharmacist_model.dart';

enum GetallPharmacyStatus { initial, loading, success, error }

class GetallPharmacyState {
  final GetallPharmacyStatus status;
  final List<SinglePharmacy>? pharmacies;
  final String? errorMessage;

  GetallPharmacyState({
    this.status = GetallPharmacyStatus.initial,
    this.pharmacies,
    this.errorMessage,
  });

  GetallPharmacyState copyWith({
    GetallPharmacyStatus? status,
    List<SinglePharmacy>? pharmacies,
    String? errorMessage,
  }) {
    return GetallPharmacyState(
      status: status ?? this.status,
      pharmacies: pharmacies ?? this.pharmacies,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
