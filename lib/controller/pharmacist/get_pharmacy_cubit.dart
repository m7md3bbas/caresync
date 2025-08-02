import 'package:caresync/controller/pharmacist/getall_pharmacy_state.dart';
import 'package:caresync/core/service/pharmacist_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetPharmacyCubit extends Cubit<GetallPharmacyState> {
  final PharmacistService pharmacistService;
  GetPharmacyCubit(this.pharmacistService) : super(GetallPharmacyState());

  Future<void> getPharmacy() async {
    emit(state.copyWith(status: GetallPharmacyStatus.loading));
    try {
      final resutl = await pharmacistService.getPharmacistCategories();
      emit(
        state.copyWith(
          status: GetallPharmacyStatus.success,
          pharmacies: resutl,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: GetallPharmacyStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
