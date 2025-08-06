import 'package:caresync/controller/doctor/doctor_schedule_cubit.dart';
import 'package:caresync/controller/doctor/doctor_schedule_state.dart';
import 'package:caresync/core/shared_prefs/shared_pref_helper.dart';
import 'package:caresync/core/shared_prefs/shared_pref_keys.dart';
import 'package:caresync/models/doctor_schedule_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddEditScheduleDialog extends StatefulWidget {
  final DoctorSchedule? schedule;

  const AddEditScheduleDialog({super.key, this.schedule});

  @override
  State<AddEditScheduleDialog> createState() => _AddEditScheduleDialogState();
}

class _AddEditScheduleDialogState extends State<AddEditScheduleDialog> {
  late String selectedScheduleType;
  late DateTime weekStarting;
  String? selectedDay;
  TimeOfDay startTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay endTime = const TimeOfDay(hour: 17, minute: 0);
  bool isWorkingDay = true;
  final durationController = TextEditingController();
  final weekStartController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final existing = widget.schedule;

    selectedScheduleType = (existing?.isRecurring ?? false)
        ? 'Recurring Schedule'
        : 'Weekly Schedule';

    weekStarting = existing != null
        ? DateTime.tryParse(existing.weekStartDate) ?? DateTime.now()
        : DateTime.now();

    weekStartController.text = weekStarting.toIso8601String().split('T').first;

    selectedDay = existing != null
        ? [
            'Monday',
            'Tuesday',
            'Wednesday',
            'Thursday',
            'Friday',
            'Saturday',
            'Sunday',
          ][existing.dayOfWeek]
        : null;

    isWorkingDay = existing?.isWorkingDay ?? true;

    if (existing != null) {
      startTime = _parseTime(existing.startTime);
      endTime = _parseTime(existing.endTime);
      durationController.text = existing.appointmentDuration.toString();
    } else {
      durationController.text = '30';
    }
  }

  TimeOfDay _parseTime(String? timeStr) {
    if (timeStr == null || timeStr.isEmpty) {
      return const TimeOfDay(hour: 9, minute: 0);
    }
    final parts = timeStr.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  String _formatTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:00';
  }

  int _dayToIndex(String? day) {
    return [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ].indexOf(day ?? 'Monday');
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DoctorScheduleCubit, DoctorScheduleState>(
      listener: (context, state) {
        if (state.status == DoctorScheduleStatus.addSuccess ||
            state.status == DoctorScheduleStatus.updateSuccess) {
          Navigator.pop(context);
        }
        if (state.status == DoctorScheduleStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage ?? 'An error occurred')),
          );
        }
      },
      child: AlertDialog(
        title: Text(widget.schedule != null ? "Edit Schedule" : "Add Schedule"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  ChoiceChip(
                    label: const Text('Weekly Schedule'),
                    selected: selectedScheduleType == 'Weekly Schedule',
                    onSelected: (_) {
                      setState(() {
                        selectedScheduleType = 'Weekly Schedule';
                      });
                    },
                  ),
                  const SizedBox(width: 8),
                  ChoiceChip(
                    label: const Text('Recurring Schedule'),
                    selected: selectedScheduleType == 'Recurring Schedule',
                    onSelected: (_) {
                      setState(() {
                        selectedScheduleType = 'Recurring Schedule';
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (selectedScheduleType == 'Weekly Schedule')
                TextFormField(
                  readOnly: true,
                  decoration: const InputDecoration(labelText: 'Week Starting'),
                  controller: weekStartController,
                  onTap: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: weekStarting,
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                    );
                    if (picked != null) {
                      setState(() {
                        weekStarting = picked;
                        weekStartController.text = picked
                            .toIso8601String()
                            .split('T')
                            .first;
                      });
                    }
                  },
                ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Day of Week'),
                value: selectedDay,
                items: const [
                  DropdownMenuItem(value: 'Monday', child: Text('Monday')),
                  DropdownMenuItem(value: 'Tuesday', child: Text('Tuesday')),
                  DropdownMenuItem(
                    value: 'Wednesday',
                    child: Text('Wednesday'),
                  ),
                  DropdownMenuItem(value: 'Thursday', child: Text('Thursday')),
                  DropdownMenuItem(value: 'Friday', child: Text('Friday')),
                  DropdownMenuItem(value: 'Saturday', child: Text('Saturday')),
                  DropdownMenuItem(value: 'Sunday', child: Text('Sunday')),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedDay = value;
                  });
                },
              ),
              const SizedBox(height: 10),
              SwitchListTile(
                value: isWorkingDay,
                onChanged: (val) {
                  setState(() {
                    isWorkingDay = val;
                  });
                },
                title: const Text("Is Working Day"),
              ),
              if (isWorkingDay) ...[
                ListTile(
                  title: const Text("Start Time"),
                  subtitle: Text(startTime.format(context)),
                  onTap: () async {
                    TimeOfDay? picked = await showTimePicker(
                      context: context,
                      initialTime: startTime,
                    );
                    if (picked != null) {
                      setState(() {
                        startTime = picked;
                      });
                    }
                  },
                ),
                ListTile(
                  title: const Text("End Time"),
                  subtitle: Text(endTime.format(context)),
                  onTap: () async {
                    TimeOfDay? picked = await showTimePicker(
                      context: context,
                      initialTime: endTime,
                    );
                    if (picked != null) {
                      setState(() {
                        endTime = picked;
                      });
                    }
                  },
                ),
                TextFormField(
                  controller: durationController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Appointment Duration (minutes)',
                  ),
                ),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              final cubit = context.read<DoctorScheduleCubit>();
              final token =
                  SharedPrefHelper.getString(SharedPrefKeys.token) ?? '';

              final dayIndex = _dayToIndex(selectedDay);
              final schedule = DoctorSchedule(
                id: widget.schedule?.id,
                doctor: widget.schedule?.doctor,
                doctorName: widget.schedule?.doctorName,
                dayOfWeek: dayIndex,
                dayName: selectedDay,
                startTime: _formatTime(startTime),
                endTime: _formatTime(endTime),
                isWorkingDay: isWorkingDay,
                appointmentDuration:
                    int.tryParse(durationController.text) ?? 30,
                weekStartDate: selectedScheduleType == 'Recurring Schedule'
                    ? "2000-01-01"
                    : weekStartController.text,
                isRecurring: selectedScheduleType == 'Recurring Schedule',
                weekRange: widget.schedule?.weekRange,
              );

              if (schedule.id != null) {
                await cubit.updateSchedule(token, schedule);
              } else {
                await cubit.addSchedule(token, schedule);
              }
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }
}
