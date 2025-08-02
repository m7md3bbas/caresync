import 'package:caresync/controller/doctor/doctor_cubit.dart';
import 'package:caresync/controller/doctor/doctor_state.dart';
import 'package:caresync/core/colors/color_manager.dart';
import 'package:caresync/models/appoinment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorAppointmentsPage extends StatelessWidget {
  const DoctorAppointmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorCubit, DoctorState>(
      listener: (context, state) {
        if (state.state == DoctorStatus.error) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message!)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(centerTitle: true, title: const Text("Appointments")),
          body: Column(
            children: [
              const SizedBox(height: 20),

              if (state.state == DoctorStatus.success &&
                  state.appointments != null)
                _buildStatusSummary(state.appointments!)
              else
                const SizedBox(),

              const SizedBox(height: 20),
              state.state == DoctorStatus.loading
                  ? CircularProgressIndicator()
                  : state.state == DoctorStatus.success &&
                        state.appointments != null
                  ? Expanded(child: _buildAppointmentList(state.appointments!))
                  : Expanded(
                      child: Center(child: const Text("No appointments found")),
                    ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatusSummary(List<Appointment> appointments) {
    final total = appointments.length;
    final pending = appointments.where((e) => e.status == "pending").length;
    final completed = appointments.where((e) => e.status == "completed").length;
    final today = appointments
        .where((e) => e.date == DateTime.now().toString().split(" ")[0])
        .length;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            _statusCard(total.toString(), "Total"),
            const SizedBox(height: 20),
            _statusCard(pending.toString(), "Pending"),
          ],
        ),
        Column(
          children: [
            _statusCard(completed.toString(), "Completed"),
            const SizedBox(height: 20),
            _statusCard(today.toString(), "Today"),
          ],
        ),
      ],
    );
  }

  Widget _statusCard(String count, String label) {
    return Card(
      child: Container(
        width: 120,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Text(count, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildAppointmentList(List<Appointment> appointments) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        final appt = appointments[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appt.patientName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                _row(Icons.person, "Patient: ${appt.patientName}"),
                _row(Icons.calendar_today, "Date: ${appt.date}"),
                _row(Icons.access_time, "Time: ${appt.time}"),
                _row(
                  Icons.local_hospital,
                  "Specialization: ${appt.specialization}",
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.amber.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(appt.status.toUpperCase()),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () {
                        // Confirm logic here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: const Text("✔ Confirm"),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        // Reject logic here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: const Text("✖ Reject"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _row(IconData icon, String text) {
    return Row(
      children: [Icon(icon, size: 16), const SizedBox(width: 6), Text(text)],
    );
  }
}
