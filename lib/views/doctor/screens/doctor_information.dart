import 'package:caresync/core/colors/color_manager.dart';
import 'package:caresync/views/doctor/widgets/custom_list_tile.dart';
import 'package:flutter/material.dart';

class DoctorInformation extends StatefulWidget {
  const DoctorInformation({super.key});

  @override
  State<DoctorInformation> createState() => _DoctorInformationState();
}

class _DoctorInformationState extends State<DoctorInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.splashBackgroundColor,
        title: Text(
          "Doctor Information",
          style: TextStyle(color: ColorManager.primaryColorLight),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            Column(
              spacing: 16,
              children: [
                SizedBox(height: 20),
                CustomListTile(
                  headline: "Full Name:",
                  text: "text",
                  icon: Icons.person,
                ),
                CustomListTile(
                  headline: "Adrress:",
                  text: "text",
                  icon: Icons.note,
                ),
                CustomListTile(
                  headline: "Birthday:",
                  text: "text",
                  icon: Icons.candlestick_chart,
                ),
                CustomListTile(
                  headline: "Phone Number:",
                  text: "text",
                  icon: Icons.phone,
                ),
                CustomListTile(
                  headline: "Email:",
                  text: "text",
                  icon: Icons.email,
                ),
                CustomListTile(
                  headline: "Gender",
                  text: "text",
                  icon: Icons.man,
                ),
                CustomListTile(
                  headline: "Clinic",
                  text: "text",
                  icon: Icons.plus_one,
                ),
                CustomListTile(
                  headline: "Hospital",
                  text: "text",
                  icon: Icons.local_hospital,
                ),
                CustomListTile(
                  headline: "Specialization",
                  text: "text",
                  icon: Icons.folder_special,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
