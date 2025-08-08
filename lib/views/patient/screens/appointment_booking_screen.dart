import 'package:flutter/material.dart';
import 'package:caresync/core/colors/color_manager.dart';
import 'package:caresync/core/widget/custom_toast.dart';
import 'package:caresync/models/get_doctors.dart';
import 'widgets/doctor_list_widget.dart';
import 'widgets/doctor_schedule_widget.dart';
import 'widgets/booking_form_widget.dart';
import 'widgets/my_appointments_widget.dart';

enum BookingStep { doctors, schedule, booking }

enum TabSelection { bookAppointment, myAppointments }

class AppointmentBookingScreen extends StatefulWidget {
  const AppointmentBookingScreen({super.key});

  @override
  State<AppointmentBookingScreen> createState() =>
      _AppointmentBookingScreenState();
}

class _AppointmentBookingScreenState extends State<AppointmentBookingScreen>
    with SingleTickerProviderStateMixin {
  TabSelection currentTab = TabSelection.bookAppointment;
  BookingStep currentStep = BookingStep.doctors;
  GetDoctorModel? selectedDoctor;
  Map<String, dynamic>? selectedSlot;
  late TabController _tabController;

  final List<Map<String, dynamic>> steps = [
    {
      'key': BookingStep.doctors,
      'label': 'Select Doctor',
      'icon': Icons.person,
    },
    {
      'key': BookingStep.schedule,
      'label': 'Choose Time',
      'icon': Icons.schedule,
    },
    {
      'key': BookingStep.booking,
      'label': 'Book Appointment',
      'icon': Icons.check_circle,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          currentTab = _tabController.index == 0
              ? TabSelection.bookAppointment
              : TabSelection.myAppointments;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void handleDoctorSelect(GetDoctorModel doctor) {
    setState(() {
      selectedDoctor = doctor;
      currentStep = BookingStep.schedule;
    });
  }

  void handleSlotSelect(Map<String, dynamic> slot) {
    setState(() {
      selectedSlot = slot;
      currentStep = BookingStep.booking;
    });
  }

  void handleBookingComplete() {
    ToastHelper.showSuccess("Appointment booked successfully!");
    setState(() {
      currentStep = BookingStep.doctors;
      selectedDoctor = null;
      selectedSlot = null;
    });
  }

  void resetBooking() {
    setState(() {
      selectedDoctor = null;
      selectedSlot = null;
      currentStep = BookingStep.doctors;
    });
  }

  void setError(String error) {
    ToastHelper.showError(error);
  }

  void switchToBookingTab() {
    setState(() {
      currentTab = TabSelection.bookAppointment;
      _tabController.animateTo(0);
    });
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
        final isLargeScreen = screenWidth > 1200;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Appointments',
              style: TextStyle(
                fontSize: isTablet ? 24 : (isSmallScreen ? 18 : 20),
                fontWeight: FontWeight.w600,
              ),
            ),
            elevation: 0,
            toolbarHeight: isTablet ? 80 : 56,
            centerTitle: isLargeScreen,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(isTablet ? 60 : 48),
              child: Container(
                decoration: BoxDecoration(),
                child: TabBar(
                  controller: _tabController,
                  indicatorColor: Colors.white,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white70,
                  indicatorWeight: 3,
                  labelStyle: TextStyle(
                    fontSize: isTablet ? 16 : (isSmallScreen ? 12 : 14),
                    fontWeight: FontWeight.w600,
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontSize: isTablet ? 16 : (isSmallScreen ? 12 : 14),
                    fontWeight: FontWeight.w500,
                  ),
                  tabs: [
                    Tab(
                      icon: Icon(
                        Icons.add_circle_outline,
                        size: isTablet ? 24 : (isSmallScreen ? 18 : 20),
                      ),
                      text: (isTablet || !isLandscape) && !isSmallScreen
                          ? 'Book Appointment'
                          : null,
                    ),
                    Tab(
                      icon: Icon(
                        Icons.list,
                        size: isTablet ? 24 : (isSmallScreen ? 18 : 20),
                      ),
                      text: (isTablet || !isLandscape) && !isSmallScreen
                          ? 'My Appointments'
                          : null,
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: Column(
            children: [
              if (currentTab == TabSelection.bookAppointment)
                Column(
                  children: [
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: steps.map((step) {
                        final isActive = currentStep == step['key'];
                        final isCompleted =
                            steps.indexOf(step) <
                            steps.indexWhere((s) => s['key'] == currentStep);

                        return Flexible(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: isTablet ? 16 : 12,
                              vertical: isTablet ? 12 : 8,
                            ),
                            margin: EdgeInsets.symmetric(
                              horizontal: isTablet ? 8 : 4,
                            ),
                            decoration: BoxDecoration(
                              color: isActive
                                  ? ColorManager.primary
                                  : isCompleted
                                  ? ColorManager.primary.withOpacity(0.7)
                                  : Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(
                                isTablet ? 25 : 20,
                              ),
                              boxShadow: isActive
                                  ? [
                                      BoxShadow(
                                        color: ColorManager.primary.withOpacity(
                                          0.3,
                                        ),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ]
                                  : null,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  step['icon'],
                                  color: isActive || isCompleted
                                      ? Colors.white
                                      : Colors.grey.shade600,
                                  size: isTablet ? 20 : 16,
                                ),
                                if (isTablet || !isLandscape) ...[
                                  const SizedBox(width: 8),
                                  Flexible(
                                    child: Text(
                                      step['label'],
                                      style: TextStyle(
                                        color: isActive || isCompleted
                                            ? Colors.white
                                            : Colors.grey.shade600,
                                        fontSize: isTablet ? 14 : 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),

              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: isTablet ? 24 : 16,
                        vertical: isTablet ? 16 : 8,
                      ),
                      child: _buildBookingContent(),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: isTablet ? 24 : 16,
                        vertical: isTablet ? 16 : 8,
                      ),
                      child: MyAppointmentsWidget(
                        onBookNew: switchToBookingTab,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBookingContent() {
    switch (currentStep) {
      case BookingStep.doctors:
        return DoctorListWidget(onDoctorSelect: handleDoctorSelect);

      case BookingStep.schedule:
        if (selectedDoctor != null) {
          return DoctorScheduleWidget(
            doctor: selectedDoctor!,
            onSlotSelect: handleSlotSelect,
            onBack: () => setState(() => currentStep = BookingStep.doctors),
          );
        }
        return const Center(child: Text('No doctor selected'));

      case BookingStep.booking:
        if (selectedDoctor != null && selectedSlot != null) {
          return BookingFormWidget(
            doctor: selectedDoctor!,
            slot: selectedSlot!,
            onBookingComplete: handleBookingComplete,
            onBack: () => setState(() => currentStep = BookingStep.schedule),
          );
        }
        return const Center(child: Text('No slot selected'));
    }
  }
}
