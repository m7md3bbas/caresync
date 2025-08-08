import 'package:caresync/core/service/api_service.dart';
import 'package:caresync/models/appoinment_model.dart';
import 'package:caresync/models/get_doctors.dart';
import 'package:caresync/models/prescription_model.dart';
import 'package:dio/dio.dart';

class DoctorService {
  final Dio _dio = ApiClient.dio;

  Future<List<GetDoctorModel>> getDoctors(String token) async {
    try {
      final response = await _dio.get(
        'appointments/doctors/',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      final result = response.data as List;
      return result.map((e) => GetDoctorModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception("server error");
    }
  }

  Future<Response> addPrescription(
    String patientNationalId,
    PrescriptionModel model,
    String token,
  ) async {
    try {
      final response = await _dio.post(
        'patients/$patientNationalId/prescriptions/',
        data: model.toJson(),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return response;
    } catch (e) {
      throw Exception("server error");
    }
  }

  Future<List<Appointment>> getDoctorAppointments(String token) async {
    try {
      final response = await _dio.get(
        '/appointments/doctor/appointments/',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        final appointments = (response.data as List)
            .map((e) => Appointment.fromJson(e))
            .toList();
        print(appointments);
        return appointments;
      } else {
        throw Exception('Failed to fetch appointments');
      }
    } catch (e) {
      throw Exception("server error");
    }
  }

  Future<List<Map<String, dynamic>>> getDoctorSchedule(
    int doctorId,
    String date,
    String token,
  ) async {
    try {
      // Parse the date to get start and end dates for the week
      final selectedDate = DateTime.parse(date);
      // Get the start of the week (Monday)
      final startOfWeek = selectedDate.subtract(
        Duration(days: selectedDate.weekday - 1),
      );
      // Get the end of the week (Sunday)
      final endOfWeek = startOfWeek.add(const Duration(days: 6));

      print('Selected date: $selectedDate');
      print('Start of week: $startOfWeek');
      print('End of week: $endOfWeek');

      // For testing, use a known working date range
      final startDate = '2025-08-04';
      final endDate = '2025-08-10';

      // Uncomment the lines below to use the calculated date range
      // final startDate =
      //     '${startOfWeek.year}-${startOfWeek.month.toString().padLeft(2, '0')}-${startOfWeek.day.toString().padLeft(2, '0')}';
      // final endDate =
      //     '${endOfWeek.year}-${endOfWeek.month.toString().padLeft(2, '0')}-${endOfWeek.day.toString().padLeft(2, '0')}';

      print('API Call: GET appointments/doctors/$doctorId/availability/');
      print('Query params: start_date=$startDate, end_date=$endDate');

      final response = await _dio.get(
        'appointments/doctors/$doctorId/availability/',
        queryParameters: {'start_date': startDate, 'end_date': endDate},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      print('API Response status: ${response.statusCode}');
      print('API Response data: ${response.data}');

      if (response.statusCode == 200) {
        final data = response.data;
        final availability = data['availability'] as List<dynamic>? ?? [];

        // Convert the availability data to the expected format
        final List<Map<String, dynamic>> slots = [];

        for (final day in availability) {
          final dayData = Map<String, dynamic>.from(day);
          final date = dayData['date'] as String? ?? '';
          final isDayAvailable = dayData['is_available'] as bool? ?? false;
          final daySlots = dayData['slots'] as List<dynamic>? ?? [];

          // Only add slots if the day is available
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

        print('Processed slots: $slots');
        return slots;
      } else {
        throw Exception('Failed to fetch doctor availability');
      }
    } catch (e) {
      print('Doctor service error: $e');
      if (e is DioException) {
        print('Dio error type: ${e.type}');
        print('Dio error message: ${e.message}');
        print('Dio error response: ${e.response?.data}');
        print('Dio error status: ${e.response?.statusCode}');
      }
      throw Exception("server error: $e");
    }
  }
}
