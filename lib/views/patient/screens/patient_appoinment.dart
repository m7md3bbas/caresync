import 'package:flutter/material.dart';

// void main() {
//   runApp(DoctorAppointmentApp());
// }

// class DoctorAppointmentApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Doctor Appointment',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: AppointmentBookingScreen(),
//     );
//   }
// }

class AppointmentBookingScreen extends StatefulWidget {
  @override
  _AppointmentBookingScreenState createState() =>
      _AppointmentBookingScreenState();
}

class _AppointmentBookingScreenState extends State<AppointmentBookingScreen> {
  int _currentSection = 0; // 0: Doctor, 1: Time, 2: Confirmation
  Doctor? selectedDoctor;
  String? selectedDate;
  String? selectedTime;
  TextEditingController notesController = TextEditingController();

  final List<Doctor> doctors = [
    Doctor(
      name: "Dr. Hager Mahmoud",
      specialization: "Eyes",
      hospitals: ["Tanta Hospital", "Tanta Clinic"],
      phone: "01056892356",
      email: "hagermahmoud@gmail.com",
      workingHours: {
        "Monday": "1:00 AM - 2:00 PM",
        "Tuesday": "1:00 AM - 2:00 PM",
        "Wednesday": "1:00 AM - 2:00 PM",
      },
    ),
    Doctor(
      name: "Dr. John Doe",
      specialization: "Cardiology",
      hospitals: ["General Hospital", "Dee Clinic"],
      phone: "09102345678",
      email: "doctor@example.com",
      workingHours: {
        "Thursday": "9:00 AM - 5:30 PM",
        "Friday": "9:00 AM - 10:00 PM",
      },
    ),
  ];

  final List<String> availableTimes = [
    "9:00 AM",
    "10:00 AM",
    "11:00 AM",
    "12:00 PM",
    "1:00 PM",
    "2:00 PM",
    "3:00 PM",
    "4:00 PM",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book an Appointment'),
        leading: _currentSection > 0
            ? IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    _currentSection--;
                  });
                },
              )
            : null,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildProgressStep(0, "Select Doctor"),
                _buildProgressStep(1, "Choose Time"),
                _buildProgressStep(2, "Confirm"),
              ],
            ),
            SizedBox(height: 20),

            if (_currentSection == 0) _buildDoctorSelection(),
            if (_currentSection == 1) _buildTimeSelection(),
            if (_currentSection == 2) _buildConfirmation(),

            SizedBox(height: 20),
            if (_currentSection < 2)
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_currentSection == 0 && selectedDoctor == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please select a doctor")),
                      );
                      return;
                    }
                    if (_currentSection == 1 &&
                        (selectedDate == null || selectedTime == null)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please select date and time")),
                      );
                      return;
                    }
                    setState(() {
                      _currentSection++;
                    });
                  },
                  child: Text("Continue"),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressStep(int step, String title) {
    return Column(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentSection >= step ? Colors.blue : Colors.grey,
          ),
          child: Center(
            child: Text(
              (step + 1).toString(),
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: _currentSection >= step ? Colors.blue : Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildDoctorSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Choose Your Doctor",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text("Select from our qualified healthcare professionals"),
        SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(
            hintText: "Search by name, specialization, hospital...",
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 20),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: "Specialization",
            border: OutlineInputBorder(),
          ),
          items: ["All Specializations", "Eyes", "Cardiology"]
              .map((spec) => DropdownMenuItem(value: spec, child: Text(spec)))
              .toList(),
          onChanged: (value) {},
          value: "All Specializations",
        ),
        SizedBox(height: 20),
        ...doctors.map((doctor) => _buildDoctorCard(doctor)).toList(),
      ],
    );
  }

  Widget _buildDoctorCard(Doctor doctor) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          setState(() {
            selectedDoctor = doctor;
          });
        },
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(
              color: selectedDoctor == doctor
                  ? Colors.blue
                  : Colors.transparent,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                doctor.name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(doctor.specialization, style: TextStyle(color: Colors.grey)),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.location_on, size: 16, color: Colors.grey),
                  SizedBox(width: 4),
                  Text(doctor.hospitals.join(", ")),
                ],
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.phone, size: 16, color: Colors.grey),
                  SizedBox(width: 4),
                  Text(doctor.phone),
                ],
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.email, size: 16, color: Colors.grey),
                  SizedBox(width: 4),
                  Text(doctor.email),
                ],
              ),
              SizedBox(height: 8),
              if (selectedDoctor == doctor)
                Text("Selected", style: TextStyle(color: Colors.green)),
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
        Text(
          selectedDoctor!.name,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text(
          "Available Dates",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        // Simple date selector - in a real app you'd use a calendar
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children:
              [
                "Wednesday, July 30, 2025",
                "Thursday, July 31, 2025",
                "Friday, August 1, 2025",
              ].map((date) {
                return ChoiceChip(
                  label: Text(date),
                  selected: selectedDate == date,
                  onSelected: (selected) {
                    setState(() {
                      selectedDate = selected ? date : null;
                    });
                  },
                );
              }).toList(),
        ),
        SizedBox(height: 20),
        Text(
          "Available Times",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        // Time slots in a grid
        GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          childAspectRatio: 2.5,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          children: availableTimes.map((time) {
            return InkWell(
              onTap: () {
                setState(() {
                  selectedTime = time;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: selectedTime == time ? Colors.blue : Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text(
                    time,
                    style: TextStyle(
                      color: selectedTime == time ? Colors.blue : Colors.black,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildConfirmation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Confirm Your Appointment",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Text(
          "Appointment Details",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        _buildDetailRow(
          "Doctor:",
          "${selectedDoctor!.name} - ${selectedDoctor!.specialization}",
        ),
        _buildDetailRow("Date:", selectedDate!),
        _buildDetailRow("Time:", selectedTime!),
        _buildDetailRow("Hospital:", selectedDoctor!.hospitals.first),
        _buildDetailRow(
          "Clinic:",
          selectedDoctor!.hospitals.length > 1
              ? selectedDoctor!.hospitals[1]
              : "",
        ),
        _buildDetailRow("Contact:", selectedDoctor!.phone),
        _buildDetailRow("Email:", selectedDoctor!.email),
        SizedBox(height: 20),
        Text(
          "Notes for Doctor (Optional)",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text("Please describe your symptoms or reason for the visit"),
        SizedBox(height: 10),
        TextField(
          controller: notesController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText:
                "Describe your symptoms, concerns, or reason for the visit...",
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 20),
        Text(
          "Important Information",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        _buildInfoItem("Please arrive 15 minutes before your appointment time"),
        _buildInfoItem("Bring a valid ID and any relevant medical documents"),
        _buildInfoItem(
          "You can cancel your appointment up to 24 hours in advance",
        ),
        _buildInfoItem("A confirmation will be sent to your email and phone"),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                // Cancel action
                Navigator.pop(context);
              },
              child: Text("Cancel"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
            ElevatedButton(
              onPressed: () {
                // Confirm appointment
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Appointment Confirmed"),
                    content: Text(
                      "Your appointment with ${selectedDoctor!.name} on $selectedDate at $selectedTime has been confirmed.",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Text("OK"),
                      ),
                    ],
                  ),
                );
              },
              child: Text("Confirm Appointment"),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, size: 16, color: Colors.blue),
          SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

class Doctor {
  final String name;
  final String specialization;
  final List<String> hospitals;
  final String phone;
  final String email;
  final Map<String, String> workingHours;

  Doctor({
    required this.name,
    required this.specialization,
    required this.hospitals,
    required this.phone,
    required this.email,
    required this.workingHours,
  });
}
