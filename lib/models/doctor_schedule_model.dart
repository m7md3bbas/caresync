class DoctorSchedule {
  final int? id;
  final int? doctor;
  final String? doctorName;
  final int dayOfWeek;
  final String? dayName;
  final String startTime;
  final String endTime;
  final bool isWorkingDay;
  final int appointmentDuration;
  final String weekStartDate;
  final bool isRecurring;
  final String? weekRange;

  DoctorSchedule({
    this.id,
    this.doctor,
    this.doctorName,
    required this.dayOfWeek,
    this.dayName,
    required this.startTime,
    required this.endTime,
    required this.isWorkingDay,
    required this.appointmentDuration,
    required this.weekStartDate,
    required this.isRecurring,
    this.weekRange,
  });

  factory DoctorSchedule.fromJson(Map<String, dynamic> json) {
    return DoctorSchedule(
      id: json['id'],
      doctor: json['doctor'],
      doctorName: json['doctor_name'],
      dayOfWeek: json['day_of_week'],
      dayName: json['day_name'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      isWorkingDay: json['is_working_day'],
      appointmentDuration: json['appointment_duration'],
      weekStartDate: json['week_start_date'],
      isRecurring: json['is_recurring'],
      weekRange: json['week_range'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (doctor != null) 'doctor': doctor,
      'day_of_week': dayOfWeek,
      'start_time': startTime,
      'end_time': endTime,
      'is_working_day': isWorkingDay,
      'appointment_duration': appointmentDuration,
      'week_start_date': weekStartDate,
      'is_recurring': isRecurring,
    };
  }
}
