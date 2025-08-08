import 'package:caresync/controller/doctor/doctor_schedule_cubit.dart';
import 'package:caresync/controller/doctor/doctor_schedule_state.dart';
import 'package:caresync/core/locale/generated/l10n.dart';
import 'package:caresync/core/shared_prefs/shared_pref_helper.dart';
import 'package:caresync/core/shared_prefs/shared_pref_keys.dart';
import 'package:caresync/core/widget/offline_indicator.dart';
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
    return OfflineIndicator(
      token: token,
      child: Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).manageAvailability),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<DoctorScheduleCubit>().fetchSchedules(
                token,
                selectedWeek,
              );
            },
          ),
        ],
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
                  label: Text(S.of(context).weekly),
                  selected: true,
                  onSelected: (_) {},
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    // Show cache statistics
                    final stats = context.read<DoctorScheduleCubit>().getCacheStatistics();
                                         showDialog(
                       context: context,
                       builder: (context) => AlertDialog(
                         title: Text(S.of(context).cacheStatistics),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                                                     children: [
                             Text('${S.of(context).cacheBox}: ${stats['cache_box'] ?? 0} ${S.of(context).items}'),
                             Text('${S.of(context).userDataBox}: ${stats['user_data_box'] ?? 0} ${S.of(context).items}'),
                             Text('${S.of(context).apiCacheBox}: ${stats['api_cache_box'] ?? 0} ${S.of(context).items}'),
                             Text('${S.of(context).settingsBox}: ${stats['settings_box'] ?? 0} ${S.of(context).items}'),
                             const SizedBox(height: 10),
                             Text(S.of(context).cacheStatisticsDescription),
                           ],
                        ),
                                                 actions: [
                           TextButton(
                             onPressed: () => Navigator.pop(context),
                             child: Text(S.of(context).close),
                           ),
                         ],
                      ),
                    );
                  },
                                     child: Text(S.of(context).cacheStatistics),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    // Clear cache
                                         showDialog(
                       context: context,
                       builder: (context) => AlertDialog(
                         title: Text(S.of(context).clearCache),
                         content: Text(S.of(context).clearCacheDescription),
                                                 actions: [
                           TextButton(
                             onPressed: () => Navigator.pop(context),
                             child: Text(S.of(context).cancel),
                           ),
                           ElevatedButton(
                             onPressed: () {
                               Navigator.pop(context);
                               context.read<DoctorScheduleCubit>().clearCache();
                               ScaffoldMessenger.of(context).showSnackBar(
                                 SnackBar(
                                   content: Text(S.of(context).cacheClearedSuccessfully),
                                   backgroundColor: Colors.green,
                                 ),
                               );
                             },
                             style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                             child: Text(S.of(context).clearCache),
                           ),
                         ],
                      ),
                    );
                  },
                                     child: Text(S.of(context).clearCache),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    // Preload cache
                                         context.read<DoctorScheduleCubit>().preloadCache(token);
                     ScaffoldMessenger.of(context).showSnackBar(
                       SnackBar(
                         content: Text(S.of(context).preloadingCache),
                         backgroundColor: Colors.blue,
                       ),
                     );
                  },
                                     child: Text(S.of(context).preloadCache),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Use a custom date picker that handles the date constraints properly
            TextFormField(
              controller: dateController,
              readOnly: true,
                             decoration: InputDecoration(
                 labelText: S.of(context).selectWeekDate,
                suffixIcon: Icon(Icons.calendar_month),
                border: OutlineInputBorder(),
              ),
              onTap: () async {
                try {
                  final now = DateTime.now();
                  final startOfWeek = getStartOfWeek(now);
                  final initialDate =
                      DateTime.tryParse(dateController.text) ?? startOfWeek;

                  // Ensure initialDate is not before today
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
                    final startOfPickedWeek = getStartOfWeek(picked);
                    final formattedWeek = DateFormat(
                      'yyyy-MM-dd',
                    ).format(startOfPickedWeek);

                    print('=== DATE PICKER DEBUG ===');
                    print('Picked date: $picked');
                    print('Start of picked week: $startOfPickedWeek');
                    print('Formatted week: $formattedWeek');
                    print('Picked weekday: ${picked.weekday}');
                    print('=== END DATE PICKER DEBUG ===');

                    setState(() {
                      selectedWeek = formattedWeek;
                      dateController.text = formattedWeek;
                    });

                    context.read<DoctorScheduleCubit>().fetchSchedules(
                      token,
                      formattedWeek,
                    );
                  }
                } catch (e) {
                  print('Date picker error: $e');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error selecting date: $e')),
                  );
                }
              },
            ),
            const SizedBox(height: 12),
                         Text(
               "${S.of(context).week}: ${getWeekRangeText(selectedWeek)}",
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

                  // Debug: Print schedules for debugging
                  print('=== DEBUG INFO ===');
                  print('Total schedules: ${schedules.length}');
                  print('Selected week: $selectedWeek');
                  print('Selected week type: ${selectedWeek.runtimeType}');

                  schedules.forEach((schedule) {
                    print(
                      'Schedule: ${schedule.weekStartDate} (${schedule.weekStartDate.runtimeType}) - ${schedule.dayName} - ${schedule.isWorkingDay}',
                    );
                  });

                  final filteredSchedules = schedules.where((schedule) {
                    final matchesWeek = schedule.weekStartDate == selectedWeek;
                    final isRecurring = schedule.isRecurring;
                    print(
                      'Filtering: ${schedule.dayName} - weekStart="${schedule.weekStartDate}" (${schedule.weekStartDate.runtimeType}) - selectedWeek="$selectedWeek" (${selectedWeek.runtimeType}) - matches=$matchesWeek - recurring=$isRecurring',
                    );

                    // Additional debugging for week comparison
                    if (!matchesWeek && !isRecurring) {
                      print(
                        '  ❌ Schedule NOT matching week: ${schedule.weekStartDate} != $selectedWeek',
                      );
                    } else {
                      print(
                        '  ✅ Schedule matching: ${schedule.weekStartDate} == $selectedWeek OR recurring=$isRecurring',
                      );
                    }

                    return matchesWeek || isRecurring;
                  }).toList();

                  print('Filtered schedules: ${filteredSchedules.length}');
                  print('=== END DEBUG ===');

                  if (filteredSchedules.isEmpty) {
                                         return Center(
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Text(S.of(context).noSchedulesFound),
                           const SizedBox(height: 20),
                           ElevatedButton(
                             onPressed: () {
                               showDialog(
                                 context: context,
                                 builder: (_) => BlocProvider.value(
                                   value: context.read<DoctorScheduleCubit>(),
                                   child: AddEditScheduleDialog(
                                     currentWeekStart: selectedWeek,
                                   ),
                                 ),
                               );
                             },
                             child: Text(S.of(context).addScheduleForThisWeek),
                           ),
                         ],
                       ),
                     );
                  }

                                     final dayNames = [
                     S.of(context).monday,
                     S.of(context).tuesday,
                     S.of(context).wednesday,
                     S.of(context).thursday,
                     S.of(context).friday,
                     S.of(context).saturday,
                     S.of(context).sunday,
                   ];

                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      key: ValueKey(selectedWeek),
                                             columns: [
                         DataColumn(label: Text(S.of(context).week)),
                         DataColumn(label: Text(S.of(context).day)),
                         DataColumn(label: Text(S.of(context).working)),
                         DataColumn(label: Text(S.of(context).hours)),
                         DataColumn(label: Text(S.of(context).duration)),
                         DataColumn(label: Text(S.of(context).actions)),
                       ],
                      rows: filteredSchedules.map((schedule) {
                                                 final weekText = schedule.isRecurring
                             ? S.of(context).recurring
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
                               Text(schedule.isWorkingDay ? S.of(context).yes : S.of(context).no),
                             ),
                                                         DataCell(
                               Text(
                                 schedule.isWorkingDay
                                     ? '${schedule.startTime} - ${schedule.endTime}'
                                     : S.of(context).dayOff,
                               ),
                             ),
                            DataCell(
                              Text('${schedule.appointmentDuration} min'),
                            ),
                                                         DataCell(
                               CutomElvatedButton(
                                 text: S.of(context).edit,
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => AddEditScheduleDialog(
                                      schedule: schedule,
                                      currentWeekStart: selectedWeek,
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
              child: AddEditScheduleDialog(currentWeekStart: selectedWeek),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    ));
  }
}
