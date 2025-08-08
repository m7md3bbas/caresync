import 'package:caresync/core/widget/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:caresync/core/colors/color_manager.dart';
import 'package:caresync/models/appoinment_model.dart';
import 'package:caresync/core/service/patient_service.dart';
import 'package:caresync/core/shared_prefs/shared_pref_helper.dart';
import 'package:caresync/core/shared_prefs/shared_pref_keys.dart';

class MyAppointmentsWidget extends StatefulWidget {
  final VoidCallback onBookNew;

  const MyAppointmentsWidget({super.key, required this.onBookNew});

  @override
  State<MyAppointmentsWidget> createState() => _MyAppointmentsWidgetState();
}

class _MyAppointmentsWidgetState extends State<MyAppointmentsWidget> {
  List<Appointment> appointments = [];
  List<Appointment> filteredAppointments = [];
  String statusFilter = 'all';
  String sortBy = 'date';
  String sortOrder = 'asc';
  bool isLoading = true;
  final PatientService _patientService = PatientService();

  @override
  void initState() {
    super.initState();
    _loadAppointments();
  }

  Future<void> _loadAppointments() async {
    setState(() {
      isLoading = true;
    });

    try {
      final token = SharedPrefHelper.getString(SharedPrefKeys.token) ?? '';
      final appointmentsList = await _patientService.getMyAppointments(token);

      setState(() {
        appointments = appointmentsList;
        isLoading = false;
      });

      _filterAndSortAppointments();
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _filterAndSortAppointments() {
    var filtered = appointments;

    if (statusFilter != 'all') {
      filtered = filtered
          .where((appointment) => appointment.status == statusFilter)
          .toList();
    }

    filtered.sort((a, b) {
      dynamic valueA, valueB;

      switch (sortBy) {
        case 'date':
          valueA = DateTime.parse('${a.date}T${a.time}');
          valueB = DateTime.parse('${b.date}T${b.time}');
          break;
        case 'doctor':
          valueA = a.doctorName.toLowerCase();
          valueB = b.doctorName.toLowerCase();
          break;
        case 'status':
          valueA = a.status;
          valueB = b.status;
          break;
        default:
          return 0;
      }

      if (sortOrder == 'asc') {
        return valueA.compareTo(valueB);
      } else {
        return valueB.compareTo(valueA);
      }
    });

    setState(() {
      filteredAppointments = filtered;
    });
  }

  Future<void> _handleCancelAppointment(int appointmentId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Appointment'),
        content: const Text(
          'Are you sure you want to cancel this appointment?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Yes'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      final token = SharedPrefHelper.getString(SharedPrefKeys.token) ?? '';
      await _patientService.cancelAppointment(appointmentId, token);

      await _loadAppointments();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Appointment cancelled successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ToastHelper.showError(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final screenHeight = constraints.maxHeight;
        final isTablet = screenWidth > 600;
        final isLandscape = screenWidth > screenHeight;
        final isSmallScreen = screenWidth < 400;

        return Scaffold(
          body: Column(
            children: [
              // Header
              SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'My Appointments',
                        style: TextStyle(
                          fontSize: isTablet ? 24 : (isSmallScreen ? 18 : 20),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: widget.onBookNew,
                      icon: Icon(Icons.add, size: isTablet ? 20 : 16),
                      label: Text(
                        'Book New',
                        style: TextStyle(
                          fontSize: isTablet ? 16 : 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            isTablet ? 12 : 8,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: isTablet ? 20 : 16,
                          vertical: isTablet ? 12 : 8,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Stats
              _buildStats(isTablet, isSmallScreen),

              // Filters
              _buildFilters(isTablet, isSmallScreen, isLandscape),

              // Appointments List
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _buildAppointmentsList(isTablet, isSmallScreen),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStats(bool isTablet, bool isSmallScreen) {
    final statusCounts = <String, int>{};
    for (final appointment in appointments) {
      statusCounts[appointment.status] =
          (statusCounts[appointment.status] ?? 0) + 1;
    }

    final stats = <Map<String, dynamic>>[
      {
        'label': 'Total',
        'value': appointments.length.toString(),
        'color': ColorManager.primary,
        'icon': Icons.calendar_today,
      },
      {
        'label': 'Pending',
        'value': (statusCounts['pending'] ?? 0).toString(),
        'color': Colors.orange,
        'icon': Icons.schedule,
      },
      {
        'label': 'Confirmed',
        'value': (statusCounts['confirmed'] ?? 0).toString(),
        'color': Colors.green,
        'icon': Icons.check_circle,
      },
      {
        'label': 'Completed',
        'value': (statusCounts['completed'] ?? 0).toString(),
        'color': Colors.blue,
        'icon': Icons.done,
      },
    ];

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: isTablet ? 24 : 16,
        vertical: isTablet ? 16 : 8,
      ),
      padding: EdgeInsets.all(isTablet ? 24 : 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(isTablet ? 16 : 12),
      ),
      child: isTablet || !isSmallScreen
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: stats
                  .map(
                    (stat) => Expanded(
                      child: _buildStatItem(
                        stat['label'] as String,
                        stat['value'] as String,
                        stat['color'] as Color,
                        stat['icon'] as IconData,
                        isTablet,
                        isSmallScreen,
                      ),
                    ),
                  )
                  .toList(),
            )
          : Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: stats
                      .take(2)
                      .map(
                        (stat) => Expanded(
                          child: _buildStatItem(
                            stat['label'] as String,
                            stat['value'] as String,
                            stat['color'] as Color,
                            stat['icon'] as IconData,
                            isTablet,
                            isSmallScreen,
                          ),
                        ),
                      )
                      .toList(),
                ),
                SizedBox(height: isTablet ? 16 : 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: stats
                      .skip(2)
                      .map(
                        (stat) => Expanded(
                          child: _buildStatItem(
                            stat['label'] as String,
                            stat['value'] as String,
                            stat['color'] as Color,
                            stat['icon'] as IconData,
                            isTablet,
                            isSmallScreen,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
    );
  }

  Widget _buildStatItem(
    String label,
    String value,
    Color color,
    IconData icon,
    bool isTablet,
    bool isSmallScreen,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: isTablet ? 8 : 4,
        vertical: isTablet ? 4 : 2,
      ),
      padding: EdgeInsets.all(isTablet ? 16 : (isSmallScreen ? 8 : 12)),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(isTablet ? 12 : 8),
        border: Border.all(color: color.withOpacity(0.2), width: 1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: color,
            size: isTablet ? 32 : (isSmallScreen ? 16 : 24),
          ),
          SizedBox(height: isTablet ? 12 : (isSmallScreen ? 4 : 8)),
          Text(
            value,
            style: TextStyle(
              fontSize: isTablet ? 28 : (isSmallScreen ? 16 : 22),
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: isTablet ? 4 : (isSmallScreen ? 2 : 2)),
          Text(
            label,
            style: TextStyle(
              fontSize: isTablet ? 14 : (isSmallScreen ? 8 : 12),
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildFilters(bool isTablet, bool isSmallScreen, bool isLandscape) {
    final statusItems = [
      const DropdownMenuItem(value: 'all', child: Text('All Statuses')),
      const DropdownMenuItem(value: 'pending', child: Text('Pending')),
      const DropdownMenuItem(value: 'confirmed', child: Text('Confirmed')),
      const DropdownMenuItem(value: 'cancelled', child: Text('Cancelled')),
      const DropdownMenuItem(value: 'completed', child: Text('Completed')),
    ];

    final sortItems = [
      const DropdownMenuItem(value: 'date', child: Text('Date & Time')),
      const DropdownMenuItem(value: 'doctor', child: Text('Doctor Name')),
      const DropdownMenuItem(value: 'status', child: Text('Status')),
    ];

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: isTablet ? 24 : 16,
        vertical: isTablet ? 8 : 4,
      ),
      padding: EdgeInsets.all(isTablet ? 20 : 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(isTablet ? 12 : 8),
      ),
      child: isLandscape && !isTablet
          ? Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildFilterDropdown(
                        'Status',
                        statusFilter,
                        statusItems,
                        (value) {
                          if (value != null && value != statusFilter) {
                            setState(() {
                              statusFilter = value;
                            });
                            _filterAndSortAppointments();
                          }
                        },
                        isTablet,
                        isSmallScreen,
                      ),
                    ),
                    SizedBox(width: isTablet ? 16 : 12),
                    Expanded(
                      child: _buildFilterDropdown(
                        'Sort by',
                        sortBy,
                        sortItems,
                        (value) {
                          if (value != null && value != sortBy) {
                            setState(() {
                              sortBy = value;
                            });
                            _filterAndSortAppointments();
                          }
                        },
                        isTablet,
                        isSmallScreen,
                      ),
                    ),
                    SizedBox(width: isTablet ? 16 : 12),
                    _buildSortOrderButton(isTablet, isSmallScreen),
                  ],
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: _buildFilterDropdown(
                    'Status',
                    statusFilter,
                    statusItems,
                    (value) {
                      if (value != null && value != statusFilter) {
                        setState(() {
                          statusFilter = value;
                        });
                        _filterAndSortAppointments();
                      }
                    },
                    isTablet,
                    isSmallScreen,
                  ),
                ),
                SizedBox(width: isTablet ? 16 : 12),
                Expanded(
                  child: _buildFilterDropdown(
                    'Sort by',
                    sortBy,
                    sortItems,
                    (value) {
                      if (value != null && value != sortBy) {
                        setState(() {
                          sortBy = value;
                        });
                        _filterAndSortAppointments();
                      }
                    },
                    isTablet,
                    isSmallScreen,
                  ),
                ),
                SizedBox(width: isTablet ? 16 : 12),
                _buildSortOrderButton(isTablet, isSmallScreen),
              ],
            ),
    );
  }

  Widget _buildFilterDropdown(
    String label,
    String value,
    List<DropdownMenuItem<String>> items,
    Function(String?) onChanged,
    bool isTablet,
    bool isSmallScreen,
  ) {
    // Ensure the value exists in the items
    final validValue = items.any((item) => item.value == value)
        ? value
        : items.first.value;

    return DropdownButtonFormField<String>(
      key: ValueKey('${label}_$validValue'),
      value: validValue,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(isTablet ? 12 : 8),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: isTablet ? 16 : (isSmallScreen ? 8 : 12),
          vertical: isTablet ? 16 : (isSmallScreen ? 8 : 12),
        ),
        labelStyle: TextStyle(
          fontSize: isTablet ? 16 : (isSmallScreen ? 12 : 14),
          fontWeight: FontWeight.w500,
        ),
      ),
      items: items,
      onChanged: (newValue) {
        if (newValue != null && newValue != validValue) {
          onChanged(newValue);
        }
      },
      style: TextStyle(
        fontSize: isTablet ? 16 : (isSmallScreen ? 12 : 14),
        fontWeight: FontWeight.w500,
      ),
      icon: Icon(
        Icons.arrow_drop_down,
        size: isTablet ? 24 : (isSmallScreen ? 16 : 20),
        color: ColorManager.primary,
      ),
    );
  }

  Widget _buildSortOrderButton(bool isTablet, bool isSmallScreen) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(isTablet ? 12 : 8),
        border: Border.all(color: ColorManager.primary.withOpacity(0.3)),
      ),
      child: IconButton(
        onPressed: () {
          setState(() {
            sortOrder = sortOrder == 'asc' ? 'desc' : 'asc';
          });
          _filterAndSortAppointments();
        },
        icon: Icon(
          sortOrder == 'asc' ? Icons.arrow_upward : Icons.arrow_downward,
          size: isTablet ? 24 : (isSmallScreen ? 16 : 20),
          color: ColorManager.primary,
        ),
        tooltip: 'Sort ${sortOrder == 'asc' ? 'Descending' : 'Ascending'}',
        padding: EdgeInsets.all(isTablet ? 12 : (isSmallScreen ? 8 : 10)),
      ),
    );
  }

  Widget _buildAppointmentsList(bool isTablet, bool isSmallScreen) {
    if (filteredAppointments.isEmpty) {
      return _buildNoAppointments(isTablet, isSmallScreen);
    }

    return ListView.builder(
      padding: EdgeInsets.all(isTablet ? 24 : 16),
      itemCount: filteredAppointments.length,
      itemBuilder: (context, index) {
        final appointment = filteredAppointments[index];
        return _buildAppointmentCard(appointment, isTablet, isSmallScreen);
      },
    );
  }

  Widget _buildNoAppointments(bool isTablet, bool isSmallScreen) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.calendar_today,
            size: isTablet ? 80 : 64,
            color: Colors.grey.shade400,
          ),
          SizedBox(height: isTablet ? 24 : 16),
          Text(
            appointments.isEmpty
                ? 'No appointments yet'
                : 'No appointments match your filters',
            style: TextStyle(
              fontSize: isTablet ? 22 : 18,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: isTablet ? 16 : 8),
          if (appointments.isEmpty)
            ElevatedButton(
              onPressed: widget.onBookNew,
              child: Text(
                'Book Your First Appointment',
                style: TextStyle(fontSize: isTablet ? 16 : 14),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAppointmentCard(
    Appointment appointment,
    bool isTablet,
    bool isSmallScreen,
  ) {
    // final isUpcoming = _isUpcoming(appointment.date, appointment.time);

    return Card(
      margin: EdgeInsets.only(bottom: isTablet ? 20 : 16),
      elevation: isTablet ? 4 : 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(isTablet ? 16 : 12),
      ),
      child: Padding(
        padding: EdgeInsets.all(isTablet ? 24 : 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appointment.doctorName,
                        style: TextStyle(
                          fontSize: isTablet ? 22 : (isSmallScreen ? 16 : 18),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (appointment.specialization.isNotEmpty)
                        Text(
                          appointment.specialization,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: isTablet ? 18 : (isSmallScreen ? 12 : 14),
                          ),
                        ),
                    ],
                  ),
                ),
                _buildStatusBadge(appointment.status, isTablet, isSmallScreen),
              ],
            ),
            SizedBox(height: isTablet ? 24 : 16),

            // Details
            _buildDetailItem(
              Icons.calendar_today,
              _formatDate(appointment.date),
              isTablet,
              isSmallScreen,
            ),
            _buildDetailItem(
              Icons.access_time,
              _formatTime(appointment.time),
              isTablet,
              isSmallScreen,
            ),

            if (appointment.notes?.isNotEmpty == true) ...[
              SizedBox(height: isTablet ? 20 : 12),
              Text(
                'Your Notes:',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: isTablet ? 18 : (isSmallScreen ? 14 : 14),
                ),
              ),
              SizedBox(height: isTablet ? 8 : 4),
              Text(
                appointment.notes!,
                style: TextStyle(
                  fontSize: isTablet ? 16 : (isSmallScreen ? 12 : 14),
                  color: Colors.grey,
                ),
              ),
            ],

            // Actions
            if (appointment.canCancel && appointment.status != 'cancelled')
              Padding(
                padding: EdgeInsets.only(top: isTablet ? 24 : 16),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () =>
                            _handleCancelAppointment(appointment.id),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                          side: const BorderSide(color: Colors.red),
                          padding: EdgeInsets.symmetric(
                            vertical: isTablet ? 16 : 12,
                            horizontal: isTablet ? 24 : 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              isTablet ? 12 : 8,
                            ),
                          ),
                        ),
                        child: Text(
                          'Cancel Appointment',
                          style: TextStyle(
                            fontSize: isTablet ? 16 : 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            if (appointment.status == 'completed')
              Padding(
                padding: EdgeInsets.only(top: isTablet ? 24 : 16),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.green.shade600,
                      size: isTablet ? 24 : 16,
                    ),
                    SizedBox(width: isTablet ? 12 : 8),
                    Text(
                      'Appointment completed',
                      style: TextStyle(
                        color: Colors.green.shade600,
                        fontWeight: FontWeight.w500,
                        fontSize: isTablet ? 16 : 14,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status, bool isTablet, bool isSmallScreen) {
    final statusColors = {
      'pending': Colors.orange,
      'confirmed': Colors.green,
      'cancelled': Colors.red,
      'completed': Colors.blue,
    };

    final statusIcons = {
      'pending': Icons.schedule,
      'confirmed': Icons.check_circle,
      'cancelled': Icons.cancel,
      'completed': Icons.done,
    };

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isTablet ? 16 : 8,
        vertical: isTablet ? 12 : 4,
      ),
      decoration: BoxDecoration(
        color: statusColors[status]?.withOpacity(0.1),
        borderRadius: BorderRadius.circular(isTablet ? 16 : 12),
        border: Border.all(color: statusColors[status] ?? Colors.grey),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            statusIcons[status] ?? Icons.info,
            size: isTablet ? 18 : 12,
            color: statusColors[status],
          ),
          SizedBox(width: isTablet ? 8 : 4),
          Text(
            status.toUpperCase(),
            style: TextStyle(
              fontSize: isTablet ? 14 : 10,
              fontWeight: FontWeight.bold,
              color: statusColors[status],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(
    IconData icon,
    String text,
    bool isTablet,
    bool isSmallScreen,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: isTablet ? 16 : 8),
      child: Row(
        children: [
          Icon(icon, size: isTablet ? 24 : 16, color: Colors.grey),
          SizedBox(width: isTablet ? 16 : 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: isTablet ? 18 : (isSmallScreen ? 12 : 14),
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String dateString) {
    final date = DateTime.parse(dateString);
    final months = [
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
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  String _formatTime(String timeString) {
    final parts = timeString.split(':');
    final hour = int.parse(parts[0]);
    final ampm = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour % 12 == 0 ? 12 : hour % 12;
    return '$displayHour:${parts[1]} $ampm';
  }

  // bool _isUpcoming(String dateString, String timeString) {
  //   final appointmentDateTime = DateTime.parse('${dateString}T$timeString');
  //   return appointmentDateTime.isAfter(DateTime.now());
  // }
}
