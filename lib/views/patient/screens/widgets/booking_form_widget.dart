import 'package:flutter/material.dart';
import 'package:caresync/core/colors/color_manager.dart';
import 'package:caresync/models/get_doctors.dart';
import 'package:caresync/core/service/patient_service.dart';
import 'package:caresync/models/book_appoinment.dart';
import 'package:caresync/core/shared_prefs/shared_pref_helper.dart';
import 'package:caresync/core/shared_prefs/shared_pref_keys.dart';

class BookingFormWidget extends StatefulWidget {
  final GetDoctorModel doctor;
  final Map<String, dynamic> slot;
  final VoidCallback onBookingComplete;
  final VoidCallback onBack;

  const BookingFormWidget({
    super.key,
    required this.doctor,
    required this.slot,
    required this.onBookingComplete,
    required this.onBack,
  });

  @override
  State<BookingFormWidget> createState() => _BookingFormWidgetState();
}

class _BookingFormWidgetState extends State<BookingFormWidget> {
  final TextEditingController _notesController = TextEditingController();
  bool isSubmitting = false;
  final PatientService _patientService = PatientService();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  String _formatDate(String dateString) {
    final date = DateTime.parse(dateString);
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    final days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];

    return '${days[date.weekday - 1]}, ${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  String _formatTime(String timeString) {
    final parts = timeString.split(':');
    final hour = int.parse(parts[0]);
    final ampm = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour % 12 == 0 ? 12 : hour % 12;
    return '$displayHour:${parts[1]} $ampm';
  }

  Future<void> _handleSubmit() async {
    if (isSubmitting) return;

    setState(() {
      isSubmitting = true;
    });

    try {
      final token = SharedPrefHelper.getString(SharedPrefKeys.token) ?? '';

      final appointmentData = AppointmentBookingModel(
        doctor: widget.doctor.id,
        appointmentDate: widget.slot['date'],
        appointmentTime: widget.slot['time'],
        notes: _notesController.text.trim(),
      );
      print(appointmentData.toJson());

      await _patientService.bookAppointment(appointmentData, token);

      widget.onBookingComplete();
    } finally {
      if (mounted) {
        setState(() {
          isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.slot);
    print(widget.doctor);
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            child: Row(
              children: [
                IconButton(
                  onPressed: widget.onBack,
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Confirm Your Appointment',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Appointment Summary
                  _buildAppointmentSummary(),
                  const SizedBox(height: 24),

                  // Booking Form
                  _buildBookingForm(),
                  const SizedBox(height: 24),

                  // Important Notice
                  _buildImportantNotice(),
                  const SizedBox(height: 32),

                  // Action Buttons
                  _buildActionButtons(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentSummary() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Appointment Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            _buildDetailRow(
              'Doctor',
              'Dr. ${widget.doctor.fullName}${widget.doctor.specialization.isNotEmpty ? ' - ${widget.doctor.specialization}' : ''}',
            ),
            _buildDetailRow('Date', _formatDate(widget.slot['date'])),
            _buildDetailRow('Time', _formatTime(widget.slot['time'])),

            if (widget.doctor.hospital.isNotEmpty)
              _buildDetailRow('Hospital', widget.doctor.hospital),

            if (widget.doctor.clinic.isNotEmpty)
              _buildDetailRow('Clinic', widget.doctor.clinic),

            _buildDetailRow(
              'Contact',
              '📞 ${widget.doctor.phoneNumber}\n📧 ${widget.doctor.email}',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }

  Widget _buildBookingForm() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Notes for Doctor (Optional)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Please describe your symptoms or reason for the visit',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _notesController,
              maxLines: 4,
              maxLength: 500,
              decoration: InputDecoration(
                hintText:
                    'Describe your symptoms, concerns, or reason for the visit...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${_notesController.text.length}/500 characters',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImportantNotice() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.orange.shade50,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.warning, color: Colors.orange.shade700, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Important Information',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange.shade700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildNoticeItem(
                    'Please arrive 15 minutes before your appointment time',
                  ),
                  _buildNoticeItem(
                    'Bring a valid ID and any relevant medical documents',
                  ),
                  _buildNoticeItem(
                    'You can cancel your appointment up to 24 hours in advance',
                  ),
                  _buildNoticeItem(
                    'A confirmation will be sent to your email and phone',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoticeItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: TextStyle(
              color: Colors.orange.shade700,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: Colors.orange.shade700, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: isSubmitting ? null : widget.onBack,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: BorderSide(color: ColorManager.primary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Cancel', style: TextStyle(fontSize: 16)),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: isSubmitting ? null : _handleSubmit,
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: isSubmitting
                ? const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text('Booking...'),
                    ],
                  )
                : const Text(
                    'Confirm Appointment',
                    style: TextStyle(fontSize: 16),
                  ),
          ),
        ),
      ],
    );
  }
}
