class AppointmentBookingModel {
  final int doctor;
  final String appointmentDate;
  final String appointmentTime;
  final String? notes;

  AppointmentBookingModel({
    required this.doctor,
    required this.appointmentDate,
    required this.appointmentTime,
    this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'doctor': doctor,
      'appointment_date': appointmentDate,
      'appointment_time': appointmentTime,
      'notes': notes,
    };
  }
}
