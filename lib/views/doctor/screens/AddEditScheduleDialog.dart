import 'package:caresync/controller/doctor/doctor_schedule_cubit.dart';
import 'package:caresync/controller/doctor/doctor_schedule_state.dart';
import 'package:caresync/core/locale/generated/l10n.dart';
import 'package:caresync/core/shared_prefs/shared_pref_helper.dart';
import 'package:caresync/core/shared_prefs/shared_pref_keys.dart';
import 'package:caresync/core/widget/custom_toast.dart';
import 'package:caresync/models/doctor_schedule_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddEditScheduleDialog extends StatefulWidget {
  final DoctorSchedule? schedule;
  final String? currentWeekStart; // Add this parameter

  const AddEditScheduleDialog({
    super.key,
    this.schedule,
    this.currentWeekStart,
  });

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
    if (widget.currentWeekStart != null && existing == null) {
      weekStarting =
          DateTime.tryParse(widget.currentWeekStart!) ?? DateTime.now();
    } else {
      weekStarting = existing != null
          ? DateTime.tryParse(existing.weekStartDate) ?? DateTime.now()
          : DateTime.now();
    }

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
        : 'Monday';

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
    try {
      final parts = timeStr.split(':');
      if (parts.length >= 2) {
        return TimeOfDay(
          hour: int.parse(parts[0]),
          minute: int.parse(parts[1]),
        );
      }
    } catch (e) {}
    return const TimeOfDay(hour: 9, minute: 0);
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
        if (state.status == DoctorScheduleStatus.addSuccess) {
          ToastHelper.showSuccess(S.of(context).scheduleAddedSuccessfully);
          Navigator.pop(context);
        }
        if (state.status == DoctorScheduleStatus.updateSuccess) {
          ToastHelper.showSuccess(S.of(context).scheduleUpdatedSuccessfully);
          Navigator.pop(context);
        }
        if (state.status == DoctorScheduleStatus.error) {
          ToastHelper.showError(state.errorMessage ?? "An error occurred");
        }
      },
      child: AlertDialog(
        title: Text(
          widget.schedule != null
              ? S.of(context).editSchedule
              : S.of(context).addSchedule,
        ),
        content: SingleChildScrollView(
          child: Column(
            spacing: 12,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  ChoiceChip(
                    label: Text(S.of(context).weeklySchedule),
                    selected: selectedScheduleType == 'Weekly Schedule',
                    onSelected: (_) {
                      setState(() {
                        selectedScheduleType = 'Weekly Schedule';
                      });
                    },
                  ),
                  const SizedBox(width: 8),
                  ChoiceChip(
                    label: Text(S.of(context).recurringSchedule),
                    selected: selectedScheduleType == 'Recurring Schedule',
                    onSelected: (_) {
                      setState(() {
                        selectedScheduleType = 'Recurring Schedule';
                      });
                    },
                  ),
                ],
              ),
              if (selectedScheduleType == 'Weekly Schedule')
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: S.of(context).weekStarting,
                  ),
                  controller: weekStartController,
                  onTap: () async {
                    try {
                      final now = DateTime.now();
                      final initialDate =
                          DateTime.tryParse(weekStartController.text) ?? now;
                      final safeInitialDate = initialDate.isBefore(now)
                          ? now
                          : initialDate;

                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: safeInitialDate,
                        firstDate: now,
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
                    } catch (e) {
                      print('Date picker error: $e');
                      ToastHelper.showError(e.toString());
                    }
                  },
                ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: S.of(context).dayOfWeek),
                value: selectedDay,
                items: [
                  DropdownMenuItem(
                    value: 'Monday',
                    child: Text(S.of(context).monday),
                  ),
                  DropdownMenuItem(
                    value: 'Tuesday',
                    child: Text(S.of(context).tuesday),
                  ),
                  DropdownMenuItem(
                    value: 'Wednesday',
                    child: Text(S.of(context).wednesday),
                  ),
                  DropdownMenuItem(
                    value: 'Thursday',
                    child: Text(S.of(context).thursday),
                  ),
                  DropdownMenuItem(
                    value: 'Friday',
                    child: Text(S.of(context).friday),
                  ),
                  DropdownMenuItem(
                    value: 'Saturday',
                    child: Text(S.of(context).saturday),
                  ),
                  DropdownMenuItem(
                    value: 'Sunday',
                    child: Text(S.of(context).sunday),
                  ),
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
                title: Text(S.of(context).isWorkingDay),
              ),
              if (isWorkingDay) ...[
                ListTile(
                  title: Text(S.of(context).startTime),
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
                  title: Text(S.of(context).endTime),
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
                  decoration: InputDecoration(
                    labelText: S.of(context).appointmentDuration,
                  ),
                ),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(S.of(context).cancel),
          ),
          ElevatedButton(
            onPressed: () async {
              // Validate inputs
              if (selectedDay == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(S.of(context).pleaseSelectDay)),
                );
                return;
              }

              if (isWorkingDay) {
                if (startTime.hour > endTime.hour ||
                    (startTime.hour == endTime.hour &&
                        startTime.minute >= endTime.minute)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(S.of(context).endTimeMustBeAfterStartTime),
                    ),
                  );
                  return;
                }

                final duration = int.tryParse(durationController.text);
                if (duration == null || duration <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(S.of(context).pleaseEnterValidDuration),
                    ),
                  );
                  return;
                }
              }

              final cubit = context.read<DoctorScheduleCubit>();
              final token =
                  SharedPrefHelper.getString(SharedPrefKeys.token) ?? '';

              final dayIndex = _dayToIndex(selectedDay);

              // Use the current week start from the main page if available
              String weekStartDate;
              if (selectedScheduleType == 'Recurring Schedule') {
                weekStartDate = "2000-01-01";
              } else if (widget.currentWeekStart != null &&
                  widget.schedule == null) {
                // For new schedules, use the current week from main page
                weekStartDate = widget.currentWeekStart!;
              } else {
                // For existing schedules or when no current week is provided
                weekStartDate = weekStartController.text;
              }

              print('Creating schedule with weekStartDate: $weekStartDate');

              // Debug the week calculation
              print('=== SCHEDULE CREATION DEBUG ===');
              print('Selected schedule type: $selectedScheduleType');
              print(
                'Current week start from main page: ${widget.currentWeekStart}',
              );
              print('Week start controller text: ${weekStartController.text}');
              print('Final weekStartDate: $weekStartDate');
              print('Selected day: $selectedDay');
              print('Day index: $dayIndex');
              print('=== END SCHEDULE CREATION DEBUG ===');

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
                weekStartDate: weekStartDate,
                isRecurring: selectedScheduleType == 'Recurring Schedule',
                weekRange: widget.schedule?.weekRange,
              );

              if (schedule.id != null) {
                await cubit.updateSchedule(
                  token,
                  schedule,
                  widget.currentWeekStart ?? weekStartController.text,
                );
              } else {
                await cubit.addSchedule(
                  token,
                  schedule,
                  widget.currentWeekStart ?? weekStartController.text,
                );
              }
            },
            child: Text(S.of(context).save),
          ),
        ],
      ),
    );
  }
}
