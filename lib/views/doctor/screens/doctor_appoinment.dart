import 'package:caresync/controller/doctor/doctor_cubit.dart';
import 'package:caresync/controller/doctor/doctor_state.dart';
import 'package:caresync/core/locale/generated/l10n.dart';
import 'package:caresync/core/shared_prefs/shared_pref_helper.dart';
import 'package:caresync/core/shared_prefs/shared_pref_keys.dart';
import 'package:caresync/core/widget/custom_toast.dart';
import 'package:caresync/models/appoinment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorAppointmentsPage extends StatelessWidget {
  const DoctorAppointmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final token = SharedPrefHelper.getString(SharedPrefKeys.token);

    return BlocConsumer<DoctorCubit, DoctorState>(
      listener: (context, state) {
        if (state.state == DoctorStatus.error) {
          ToastHelper.showError(state.message!);
        } else if (state.state == DoctorStatus.sent) {
          ToastHelper.showSuccess("appointment Updated Successfully");
        }
      },
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async {
            if (token != null) {
              await context.read<DoctorCubit>().getDoctorAppointments(token);
            }
          },
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(S.of(context).appointments),
            ),
            body: Column(
              children: [
                const SizedBox(height: 20),

                // عرض الإحصائيات
                if (state.state == DoctorStatus.success &&
                    state.appointments != null)
                  StatusSummary(appointments: state.appointments!)
                else
                  const SizedBox(),

                const SizedBox(height: 20),

                // عرض البيانات أو اللودينج أو رسالة عدم وجود مواعيد
                if (state.state == DoctorStatus.loading)
                  const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (state.state == DoctorStatus.success &&
                    state.appointments != null)
                  Expanded(
                    child: _buildAppointmentList(state.appointments!, context),
                  )
                else
                  Expanded(
                    child: Center(
                      child: Text(S.of(context).noAppointmentsFound),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAppointmentList(
    List<Appointment> appointments,
    BuildContext context,
  ) {
    final token = SharedPrefHelper.getString(SharedPrefKeys.token);

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
                _row(
                  Icons.person,
                  "${S.of(context).patient}: ${appt.patientName}",
                ),
                _row(
                  Icons.calendar_today,
                  "${S.of(context).date}: ${appt.date}",
                ),
                _row(Icons.access_time, "${S.of(context).time}: ${appt.time}"),
                _row(
                  Icons.local_hospital,
                  "${S.of(context).specialization}: ${appt.specialization}",
                ),
                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _statusChip(appt.status),
                    const SizedBox(width: 12),

                    if (appt.status == "pending")
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              await context
                                  .read<DoctorCubit>()
                                  .appointmentStatusUpdate(
                                    appt.id,
                                    'confirmed',
                                    doctorNotes: 'Confirmed by doctor',
                                  );

                              ToastHelper.showSuccess(
                                S.of(context).appointmentConfirmed,
                              );

                              // Wait 1 minute before refreshing
                              await Future.delayed(const Duration(minutes: 1));

                              if (token != null) {
                                await context
                                    .read<DoctorCubit>()
                                    .getDoctorAppointments(token);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(
                                255,
                                16,
                                117,
                                19,
                              ),
                            ),
                            child: Text(S.of(context).confirm),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () async {
                              await context
                                  .read<DoctorCubit>()
                                  .appointmentStatusUpdate(
                                    appt.id,
                                    'cancelled',
                                    doctorNotes: 'Cancelled by doctor',
                                  );

                              ToastHelper.showError(
                                S.of(context).appointmentCancelled,
                              );
                              await Future.delayed(const Duration(minutes: 1));

                              if (token != null) {
                                await context
                                    .read<DoctorCubit>()
                                    .getDoctorAppointments(token);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            child: Text(S.of(context).reject),
                          ),
                        ],
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

  Widget _statusChip(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: Text(status.toUpperCase()),
    );
  }
}

class StatusSummary extends StatelessWidget {
  final List<Appointment> appointments;
  const StatusSummary({super.key, required this.appointments});

  @override
  Widget build(BuildContext context) {
    final total = appointments.length;
    final pending = appointments.where((e) => e.status == "pending").length;
    final completed = appointments.where((e) => e.status == "completed").length;

    final todayDate = DateTime.now();
    final today = appointments.where((e) {
      final apptDate = DateTime.tryParse(e.date);
      return apptDate != null &&
          apptDate.year == todayDate.year &&
          apptDate.month == todayDate.month &&
          apptDate.day == todayDate.day;
    }).length;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            _statusCard(total.toString(), S.of(context).total),
            const SizedBox(height: 20),
            _statusCard(pending.toString(), S.of(context).pending),
          ],
        ),
        Column(
          children: [
            _statusCard(completed.toString(), S.of(context).completed),
            const SizedBox(height: 20),
            _statusCard(today.toString(), S.of(context).today),
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
}
