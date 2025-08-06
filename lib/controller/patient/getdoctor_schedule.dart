import 'package:caresync/controller/patient/getdoctor_state.dart';
import 'package:caresync/core/service/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetDoctorScheduleCubit extends Cubit<DoctorScheduleState> {
  final Dio _dio;

  GetDoctorScheduleCubit(this._dio) : super(const DoctorScheduleState());

  Future<void> getDoctorSchedule({
    required int doctorId,
    required String date,
    required String token,
  }) async {
    emit(state.copyWith(status: GetDoctorScheduleStatus.loading));

    try {
      final selectedDate = DateTime.parse(date);
      final startOfWeek = selectedDate.subtract(
        Duration(days: selectedDate.weekday - 1),
      );
      final endOfWeek = startOfWeek.add(const Duration(days: 6));

      final startDate = '${startOfWeek.toIso8601String().split('T').first}';
      final endDate = '${endOfWeek.toIso8601String().split('T').first}';

      final response = await _dio.get(
        'appointments/doctors/$doctorId/availability/',
        queryParameters: {'start_date': startDate, 'end_date': endDate},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final availability = data['availability'] as List<dynamic>? ?? [];

        final List<Map<String, dynamic>> slots = [];

        for (final day in availability) {
          final dayData = Map<String, dynamic>.from(day);
          final date = dayData['date'] as String? ?? '';
          final isDayAvailable = dayData['is_available'] as bool? ?? false;
          final daySlots = dayData['slots'] as List<dynamic>? ?? [];

          if (isDayAvailable) {
            for (final slot in daySlots) {
              final slotData = Map<String, dynamic>.from(slot);
              slots.add({
                'time': slotData['time'] ?? '',
                'available': slotData['is_available'] ?? false,
                'date': date,
                'datetime': slotData['datetime'] ?? '',
              });
            }
          }
        }

        emit(
          state.copyWith(status: GetDoctorScheduleStatus.success, slots: slots),
        );
      } else {
        emit(
          state.copyWith(
            status: GetDoctorScheduleStatus.failure,
            errorMessage: 'Failed to fetch doctor availability',
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: GetDoctorScheduleStatus.failure,
          errorMessage: 'Server error: $e',
        ),
      );
    }
  }
}
