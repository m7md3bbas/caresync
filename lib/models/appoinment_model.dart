class Appointment {
  final int id;
  final String patientName;
  final String doctorName;
  final String specialization;
  final String date;
  final String time;
  final String status;
  final String? notes;
  final bool canCancel;

  Appointment({
    required this.id,
    required this.patientName,
    required this.doctorName,
    required this.specialization,
    required this.date,
    required this.time,
    required this.status,
    this.notes,
    required this.canCancel,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      patientName: json['patient_name'],
      doctorName: json['doctor_name'],
      specialization: json['doctor_specialization'],
      date: json['appointment_date'],
      time: json['appointment_time'],
      status: json['status'],
      notes: json['notes'],
      canCancel: json['can_cancel'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'patient_name': patientName,
    'doctor_name': doctorName,
    'doctor_specialization': specialization,
    'appointment_date': date,
    'appointment_time': time,
    'status': status,
    'notes': notes,
    'can_cancel': canCancel,
  };
}
