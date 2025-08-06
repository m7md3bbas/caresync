import 'package:caresync/controller/doctor/get_doctor_cubit.dart';
import 'package:caresync/controller/doctor/get_doctor_state.dart';
import 'package:caresync/controller/patient/book_appoinment_cubit.dart';
import 'package:caresync/controller/patient/book_appoinment_state.dart';
import 'package:caresync/core/shared_prefs/shared_pref_helper.dart';
import 'package:caresync/core/shared_prefs/shared_pref_keys.dart';
import 'package:caresync/models/book_appoinment.dart';
import 'package:caresync/models/get_doctors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppointmentBookingScreen extends StatefulWidget {
  const AppointmentBookingScreen({super.key});

  @override
  State<AppointmentBookingScreen> createState() =>
      _AppointmentBookingScreenState();
}

class _AppointmentBookingScreenState extends State<AppointmentBookingScreen> {
  int _currentSection = 0;
  GetDoctorModel? selectedDoctor;
  String? selectedDate;
  String? selectedTime;
  TextEditingController notesController = TextEditingController();
  late int counter;
  @override
  void initState() {
    counter = 0;
    super.initState();
  }

  final List<String> availableTimes = [
    "09:00",
    "10:00",
    "11:00",
    "12:00",
    "13:00",
    "14:00",
    "15:00",
    "16:00",
  ];
  List<GetDoctorModel>? previousDoctors;

  final List<String> availableDates = [
    "2025-07-30",
    "2025-07-31",
    "2025-08-04",
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetDoctorsCubit, GetDoctorsState>(
      listener: (context, state) {
        if (state.status == GetDoctorsStatus.error) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("server error")));
        }
        if (state.status == GetDoctorsStatus.success) {
          final newDoctors = state.doctors ?? [];
          final isSame =
              previousDoctors?.length == newDoctors.length &&
              previousDoctors?.every((doc) => newDoctors.contains(doc)) == true;

          previousDoctors = newDoctors;

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                newDoctors.isEmpty
                    ? "No doctors available"
                    : isSame
                    ? "You are up to date"
                    : "Doctor list updated",
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Book an Appointment'),
            centerTitle: true,
            leading: _currentSection > 0
                ? IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => setState(() => _currentSection--),
                  )
                : null,
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              setState(() {
                counter++;
              });
              if (_currentSection == 0) {
                await context.read<GetDoctorsCubit>().fetchDoctors(
                  SharedPrefHelper.getString(SharedPrefKeys.token) ?? '',
                );
              }
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildProgressStep(0, "Select Doctor"),
                      _buildProgressStep(1, "Choose Time"),
                      _buildProgressStep(2, "Confirm"),
                    ],
                  ),
                  const SizedBox(height: 20),

                  if (_currentSection == 0) _buildDoctorSelection(),
                  if (_currentSection == 1) _buildTimeSelection(),
                  if (_currentSection == 2) _buildConfirmation(),

                  const SizedBox(height: 20),

                  if (_currentSection < 2)
                    Center(
                      child: ElevatedButton(
                        onPressed: _handleContinue,
                        child: const Text("Continue"),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _handleContinue() {
    if (_currentSection == 0 && selectedDoctor == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please select a doctor")));
      return;
    }
    if (_currentSection == 1 &&
        (selectedDate == null || selectedTime == null)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select date and time")),
      );
      return;
    }
    setState(() => _currentSection++);
  }

  Widget _buildProgressStep(int step, String title) {
    return Column(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentSection >= step
                ? Theme.of(context).colorScheme.primary
                : null,
          ),
          child: Center(
            child: Text(
              (step + 1).toString(),
              style: TextStyle(
                color: _currentSection >= step
                    ? Theme.of(context).colorScheme.onPrimary
                    : null,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: _currentSection >= step
                ? Theme.of(context).colorScheme.primary
                : null,
          ),
        ),
      ],
    );
  }

  Widget _buildDoctorSelection() {
    return BlocBuilder<GetDoctorsCubit, GetDoctorsState>(
      builder: (context, state) {
        if (state.status == GetDoctorsStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.doctors == null || state.doctors!.isEmpty) {
          return const Center(child: Text("No doctors available"));
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.doctors!.length,
          itemBuilder: (context, index) {
            final doctor = state.doctors![index];
            return _buildDoctorCard(doctor);
          },
        );
      },
    );
  }

  Widget _buildDoctorCard(GetDoctorModel doctor) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () => setState(() => selectedDoctor = doctor),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(
              color: selectedDoctor == doctor
                  ? Theme.of(context).colorScheme.primary
                  : Colors.transparent,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                doctor.fullName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(doctor.specialization),
              Text("${doctor.hospital} - ${doctor.clinic}"),
              Text(doctor.phoneNumber),
              Text(doctor.email),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Available Dates",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: availableDates.map((date) {
            return ChoiceChip(
              label: Text(date),
              selected: selectedDate == date,
              onSelected: (selected) =>
                  setState(() => selectedDate = selected ? date : null),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
        const Text(
          "Available Times",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 2.5,
          children: availableTimes.map((time) {
            return InkWell(
              onTap: () => setState(() => selectedTime = time),
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                ),
                child: ChoiceChip(
                  label: Text(time),
                  selected: selectedTime == time,
                  onSelected: (selected) =>
                      setState(() => selectedTime = selected ? time : null),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildConfirmation() {
    return BlocConsumer<AppointmentCubit, AppointmentState>(
      listener: (context, state) {
        if (state.status == AppointmentStatus.success) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Appointment Booked")));
        } else if (state.status == AppointmentStatus.error) {
          print(state.message);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message ?? "An error occurred")),
          );
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Confirm Appointment",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            _buildDetailRow("Doctor", selectedDoctor?.fullName ?? ""),
            _buildDetailRow("Date", selectedDate ?? ""),
            _buildDetailRow("Time", selectedTime ?? ""),
            TextField(
              controller: notesController,
              decoration: const InputDecoration(labelText: "Notes (optional)"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: state.status == AppointmentStatus.loading
                  ? null
                  : () async {
                      final token =
                          SharedPrefHelper.getString(SharedPrefKeys.token) ??
                          '';
                      if (selectedDoctor == null ||
                          selectedDate == null ||
                          selectedTime == null)
                        return;

                      final model = AppointmentBookingModel(
                        doctor: selectedDoctor!.id, // ✅ Dynamic doctor ID
                        appointmentDate: selectedDate!,
                        appointmentTime: selectedTime!,
                        notes: notesController.text,
                      );
                      print(
                        "${selectedDate} ${selectedTime} ${notesController.text} ${selectedDoctor!.id} here",
                      );
                      context.read<AppointmentCubit>().bookAppointment(
                        model,
                        token,
                      );
                    },
              child: state.status == AppointmentStatus.loading
                  ? const CircularProgressIndicator()
                  : const Text("Confirm Appointment"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              "$label:",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
