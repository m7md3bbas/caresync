import 'dart:io';
import 'package:caresync/controller/profile/profile_cubit.dart';
import 'package:caresync/controller/profile/profile_state.dart';
import 'package:caresync/core/colors/color_manager.dart';
import 'package:caresync/core/shared_prefs/shared_pref_helper.dart';
import 'package:caresync/core/shared_prefs/shared_pref_keys.dart';
import 'package:caresync/views/doctor/widgets/custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class PatientInformation extends StatefulWidget {
  const PatientInformation({super.key});

  @override
  State<PatientInformation> createState() => _DoctorInformationState();
}

class _DoctorInformationState extends State<PatientInformation> {
  File? image;

  @override
  void initState() {
    super.initState();
    loadImage();
  }

  void loadImage() async {
    final imagePath = await SharedPrefHelper.getString(
      SharedPrefKeys.profileImage,
    );
    if (imagePath != null) {
      setState(() {
        image = File(imagePath);
      });
    }
  }

  void pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
        SharedPrefHelper.setString(
          SharedPrefKeys.profileImage +
              context.read<ProfileCubit>().state.doctorModel!.nationalId,
          pickedFile.path,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ColorManager.splashBackgroundColor,
            title: Text(
              "Doctor Profile",
              style: TextStyle(color: ColorManager.primaryColorLight),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: image != null
                            ? FileImage(image!)
                            : AssetImage("assets/images/doctor.jpeg")
                                  as ImageProvider,
                      ),
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.white,
                        child: IconButton(
                          onPressed: pickImage,
                          icon: Icon(Icons.camera_alt, size: 18),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    state.doctorModel?.fullName ?? "",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    state.doctorModel?.specialization ?? "",
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),

                  Divider(height: 40, thickness: 1),
                  CustomListTile(
                    headline: state.doctorModel?.hospital ?? "",
                    icon: Icons.local_hospital,
                  ),
                  CustomListTile(
                    headline: state.doctorModel?.specialization ?? "",
                    icon: Icons.favorite,
                  ),

                  CustomListTile(
                    headline: state.doctorModel?.phoneNumber ?? "",
                    icon: Icons.phone,
                  ),
                  CustomListTile(
                    headline: state.doctorModel?.email ?? "",
                    icon: Icons.email,
                  ),
                  CustomListTile(
                    headline: state.doctorModel?.address ?? "",
                    icon: Icons.location_on,
                  ),
                  CustomListTile(
                    headline: state.doctorModel?.birthday ?? "",
                    icon: Icons.cake,
                  ),
                  CustomListTile(
                    headline: state.doctorModel?.gender ?? "",
                    icon: Icons.male,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}