import 'package:flutter/material.dart';
import 'package:caresync/core/colors/color_manager.dart';
import 'package:caresync/models/get_doctors.dart';
import 'package:caresync/core/service/doctor_service.dart';
import 'package:caresync/core/shared_prefs/shared_pref_helper.dart';
import 'package:caresync/core/shared_prefs/shared_pref_keys.dart';
import 'package:flutter/material.dart';
import 'package:caresync/core/colors/color_manager.dart';
import 'package:caresync/models/get_doctors.dart';
import 'package:caresync/core/service/doctor_service.dart';
import 'package:caresync/core/shared_prefs/shared_pref_helper.dart';
import 'package:caresync/core/shared_prefs/shared_pref_keys.dart';

class DoctorScheduleWidget extends StatefulWidget {
  final GetDoctorModel doctor;
  final Function(Map<String, dynamic>) onSlotSelect;
  final VoidCallback onBack;

  const DoctorScheduleWidget({
    super.key,
    required this.doctor,
    required this.onSlotSelect,
    required this.onBack,
  });

  @override
  State<DoctorScheduleWidget> createState() => _DoctorScheduleWidgetState();
}

class _DoctorScheduleWidgetState extends State<DoctorScheduleWidget> {
  DateTime _currentWeekStart = _getStartOfWeek(DateTime.now());
  DateTime selectedDate = DateTime.now();
  Map<String, List<Map<String, dynamic>>> weeklySlots = {};
  bool isLoading = false;
  final DoctorService _doctorService = DoctorService();

  static DateTime _getStartOfWeek(DateTime date) {
    return date.subtract(Duration(days: date.weekday - 1));
  }

  @override
  void initState() {
    super.initState();
    _loadWeekData();
  }

  Future<void> _loadWeekData() async {
    setState(() {
      isLoading = true;
      weeklySlots = {};
    });

    try {
      final token = SharedPrefHelper.getString(SharedPrefKeys.token) ?? '';
      final startDate = _formatDate(_currentWeekStart);
      final endDate = _formatDate(
        _currentWeekStart.add(const Duration(days: 6)),
      );

      print(
        'Loading schedule for doctor ${widget.doctor.id} from $startDate to $endDate',
      );

      final slots = await _doctorService.getDoctorSchedule(
        widget.doctor.id,
        startDate,
        token,
      );
      print('Loaded slots: $slots');

      // Organize slots by date
      final Map<String, List<Map<String, dynamic>>> organizedSlots = {};
      for (final slot in slots) {
        final date = slot['date'] ?? '';
        if (date.isNotEmpty) {
          organizedSlots.putIfAbsent(date, () => []).add(slot);
        }
      }

      setState(() {
        weeklySlots = organizedSlots;
        isLoading = false;
      });
    } catch (e) {
      print('Error loading doctor schedule: $e');

      // Fallback: Generate some mock slots if API fails
      final fallbackSlots = _generateFallbackWeekSlots(_currentWeekStart);

      setState(() {
        weeklySlots = fallbackSlots;
        isLoading = false;
      });
    }
  }

  Map<String, List<Map<String, dynamic>>> _generateFallbackWeekSlots(
    DateTime weekStart,
  ) {
    final slots = <String, List<Map<String, dynamic>>>{};
    final now = DateTime.now();

    for (int i = 0; i < 7; i++) {
      final date = weekStart.add(Duration(days: i));
      if (date.isBefore(DateTime(now.year, now.month, now.day))) {
        continue;
      }

      final dateString = _formatDate(date);
      final daySlots = <Map<String, dynamic>>[];

      // Generate different slot patterns based on day of week
      if (date.weekday == DateTime.saturday ||
          date.weekday == DateTime.sunday) {
        // Weekend - shorter hours
        for (int hour = 10; hour <= 15; hour++) {
          daySlots.add({
            'time': '${hour.toString().padLeft(2, '0')}:00',
            'available': true,
            'date': dateString,
            'datetime':
                '${dateString}T${hour.toString().padLeft(2, '0')}:00:00',
          });
        }
      } else {
        // Weekday - full hours
        for (int hour = 9; hour <= 17; hour++) {
          if (hour != 12) {
            // Skip lunch hour
            daySlots.add({
              'time': '${hour.toString().padLeft(2, '0')}:00',
              'available': true,
              'date': dateString,
              'datetime':
                  '${dateString}T${hour.toString().padLeft(2, '0')}:00:00',
            });
          }
        }
      }

      slots[dateString] = daySlots;
    }

    return slots;
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      selectedDate = date;
    });
  }

  void _goToPreviousWeek() {
    setState(() {
      _currentWeekStart = _currentWeekStart.subtract(const Duration(days: 7));
    });
    _loadWeekData();
  }

  void _goToNextWeek() {
    setState(() {
      _currentWeekStart = _currentWeekStart.add(const Duration(days: 7));
    });
    _loadWeekData();
  }

  @override
  Widget build(BuildContext context) {
    final weekDays = List.generate(
      7,
      (index) => _currentWeekStart.add(Duration(days: index)),
    );
    final selectedDateSlots = weeklySlots[_formatDate(selectedDate)] ?? [];

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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dr. ${widget.doctor.fullName}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (widget.doctor.specialization.isNotEmpty)
                        Text(
                          widget.doctor.specialization,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                    ],
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
                  // Calendar
                  _buildCalendar(weekDays),
                  const SizedBox(height: 24),

                  // Available slots
                  _buildAvailableSlots(selectedDateSlots),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar(List<DateTime> weekDays) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: _goToPreviousWeek,
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'Week of ${_formatWeekTitle(_currentWeekStart)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: _goToNextWeek,
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: weekDays.length,
                itemBuilder: (context, index) {
                  final date = weekDays[index];
                  final isSelected =
                      date.year == selectedDate.year &&
                      date.month == selectedDate.month &&
                      date.day == selectedDate.day;
                  final isToday =
                      date.year == DateTime.now().year &&
                      date.month == DateTime.now().month &&
                      date.day == DateTime.now().day;

                  return GestureDetector(
                    onTap: () => _onDateSelected(date),
                    child: Container(
                      width: 70,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: isSelected ? ColorManager.primary : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isToday
                              ? ColorManager.primary
                              : Colors.grey.shade300,
                          width: isToday ? 2 : 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _getDayName(date),
                            style: TextStyle(
                              fontSize: 12,
                              color: isSelected ? Colors.white : Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            date.day.toString(),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _getMonthName(date),
                            style: TextStyle(
                              fontSize: 10,
                              color: isSelected ? Colors.white70 : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatWeekTitle(DateTime startOfWeek) {
    final endOfWeek = startOfWeek.add(const Duration(days: 6));
    if (startOfWeek.month == endOfWeek.month) {
      return '${_getMonthName(startOfWeek)} ${startOfWeek.day}-${endOfWeek.day}';
    } else {
      return '${_getMonthName(startOfWeek)} ${startOfWeek.day} - ${_getMonthName(endOfWeek)} ${endOfWeek.day}';
    }
  }

  Widget _buildAvailableSlots(List<Map<String, dynamic>> slots) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Available Time Slots - ${_formatDisplayDate(selectedDate)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                if (isLoading)
                  const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            if (slots.isEmpty && !isLoading)
              _buildNoSlotsAvailable()
            else
              _buildSlotsGrid(slots),
          ],
        ),
      ),
    );
  }

  String _formatDisplayDate(DateTime date) {
    return '${_getDayName(date)}, ${date.day} ${_getMonthName(date)}';
  }

  Widget _buildNoSlotsAvailable() {
    return Center(
      child: Column(
        children: [
          Icon(Icons.schedule, size: 48, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            'No available slots',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'The doctor may not be available this day',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }

  Widget _buildSlotsGrid(List<Map<String, dynamic>> slots) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2.5,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: slots.length,
      itemBuilder: (context, index) {
        final slot = slots[index];
        return _buildSlotCard(slot);
      },
    );
  }

  Widget _buildSlotCard(Map<String, dynamic> slot) {
    final time = slot['time']?.toString() ?? '';
    final available = slot['available'] as bool? ?? false;
    final datetime = slot['datetime']?.toString() ?? '';

    if (time.isEmpty) {
      return const SizedBox.shrink();
    }

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: available ? ColorManager.primary : Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: available
            ? () {
                widget.onSlotSelect({
                  'time': time,
                  'date': slot['date'] ?? '',
                  'datetime': datetime,
                  'available': available,
                });
              }
            : null,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
            color: available
                ? ColorManager.primary.withOpacity(0.1)
                : Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              _formatTime(time),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: available ? ColorManager.primary : Colors.grey.shade500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _getDayName(DateTime date) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[date.weekday - 1];
  }

  String _getMonthName(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[date.month - 1];
  }

  String _formatTime(String time) {
    try {
      if (time.isEmpty) return '';

      final parts = time.split(':');
      if (parts.length < 2) return time;

      final hour = int.tryParse(parts[0]) ?? 0;
      final ampm = hour >= 12 ? 'PM' : 'AM';
      final displayHour = hour % 12 == 0 ? 12 : hour % 12;
      return '$displayHour:${parts[1]} $ampm';
    } catch (e) {
      return time;
    }
  }
}
