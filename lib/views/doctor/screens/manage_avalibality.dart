import 'package:caresync/controller/doctor/doctor_schedule_cubit.dart';
import 'package:caresync/controller/doctor/doctor_schedule_state.dart';
import 'package:caresync/core/shared_prefs/shared_pref_helper.dart';
import 'package:caresync/core/shared_prefs/shared_pref_keys.dart';
import 'package:caresync/views/auth/widgets/custom_date_picker.dart';
import 'package:caresync/views/doctor/screens/AddEditScheduleDialog.dart';
import 'package:caresync/views/doctor/widgets/cutom_elvated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class DoctorScheduleManagementPage extends StatefulWidget {
  const DoctorScheduleManagementPage({super.key});

  @override
  State<DoctorScheduleManagementPage> createState() =>
      _DoctorScheduleManagementPageState();
}

class _DoctorScheduleManagementPageState
    extends State<DoctorScheduleManagementPage> {
  late String token;
  final TextEditingController dateController = TextEditingController();
  String selectedWeek = '';

  @override
  void initState() {
    super.initState();
    token = SharedPrefHelper.getString(SharedPrefKeys.token) ?? '';
    final now = DateTime.now();
    final startOfWeek = getStartOfWeek(now);
    selectedWeek = DateFormat('yyyy-MM-dd').format(startOfWeek);
    dateController.text = selectedWeek;
    context.read<DoctorScheduleCubit>().fetchSchedules(token, selectedWeek);
  }

  DateTime getStartOfWeek(DateTime date) {
    return date.subtract(Duration(days: date.weekday - 1));
  }

  String getWeekRangeText(String weekStart) {
    final start = DateFormat('yyyy-MM-dd').parseStrict(weekStart);
    final end = start.add(const Duration(days: 6));
    final format = DateFormat('MMM dd');
    return '${format.format(start)} - ${DateFormat('MMM dd, yyyy').format(end)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Availability"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Row(
              children: [
                ChoiceChip(
                  label: const Text('Weekly'),
                  selected: true,
                  onSelected: (_) {},
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('Days Off'),
                  selected: false,
                  onSelected: (_) {},
                ),
              ],
            ),
            const SizedBox(height: 16),
            DatePickerField(
              controller: dateController,
              hintText: 'Select Week Date',
              futureDatesOnly: true,
              onChanged: (value) {
                try {
                  final pickedDate = DateTime.parse(value);
                  final startOfWeek = getStartOfWeek(pickedDate);
                  final formattedWeek = DateFormat(
                    'yyyy-MM-dd',
                  ).format(startOfWeek);

                  setState(() {
                    selectedWeek = formattedWeek;
                  });

                  context.read<DoctorScheduleCubit>().fetchSchedules(
                    token,
                    formattedWeek,
                  );
                } catch (_) {
                  debugPrint('Invalid date format');
                }
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a date';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            Text(
              "Week: ${getWeekRangeText(selectedWeek)}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<DoctorScheduleCubit, DoctorScheduleState>(
                builder: (context, state) {
                  if (state.status == DoctorScheduleStatus.loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.status == DoctorScheduleStatus.error) {
                    return Center(
                      child: Text(state.errorMessage ?? 'Error loading data'),
                    );
                  }

                  final schedules = state.schedules ?? [];

                  final filteredSchedules = schedules.where((schedule) {
                    return schedule.weekStartDate == selectedWeek ||
                        schedule.isRecurring;
                  }).toList();

                  if (filteredSchedules.isEmpty) {
                    return const Center(
                      child: Text("No schedules found for this week."),
                    );
                  }

                  final dayNames = [
                    'Monday',
                    'Tuesday',
                    'Wednesday',
                    'Thursday',
                    'Friday',
                    'Saturday',
                    'Sunday',
                  ];

                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      key: ValueKey(selectedWeek),
                      columns: const [
                        DataColumn(label: Text('Week')),
                        DataColumn(label: Text('Day')),
                        DataColumn(label: Text('Working')),
                        DataColumn(label: Text('Hours')),
                        DataColumn(label: Text('Duration')),
                        DataColumn(label: Text('Actions')),
                      ],
                      rows: filteredSchedules.map((schedule) {
                        final weekText = schedule.isRecurring
                            ? 'Recurring'
                            : schedule.weekStartDate;

                        return DataRow(
                          cells: [
                            DataCell(Text(weekText)),
                            DataCell(
                              Text(
                                dayNames[schedule.dayOfWeek % dayNames.length],
                              ),
                            ),
                            DataCell(
                              Text(schedule.isWorkingDay ? 'Yes' : 'No'),
                            ),
                            DataCell(
                              Text(
                                schedule.isWorkingDay
                                    ? '${schedule.startTime} - ${schedule.endTime}'
                                    : 'Day Off',
                              ),
                            ),
                            DataCell(
                              Text('${schedule.appointmentDuration} min'),
                            ),
                            DataCell(
                              CutomElvatedButton(
                                text: 'Edit',
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => AddEditScheduleDialog(
                                      schedule: schedule,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => BlocProvider.value(
              value: context.read<DoctorScheduleCubit>(),
              child: const AddEditScheduleDialog(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
