import 'dart:io';
import 'package:caresync/controller/auth/auth_cubit.dart';
import 'package:caresync/controller/profile/profile_cubit.dart';
import 'package:caresync/controller/profile/profile_state.dart';
import 'package:caresync/core/constants/routes_app.dart';
import 'package:caresync/core/shared_prefs/shared_pref_helper.dart';
import 'package:caresync/core/shared_prefs/shared_pref_keys.dart';
import 'package:caresync/core/theme/theme_button.dart';
import 'package:caresync/views/doctor/widgets/custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class PharmacistInformation extends StatefulWidget {
  const PharmacistInformation({super.key});

  @override
  State<PharmacistInformation> createState() => _PharmacistInformationState();
}

class _PharmacistInformationState extends State<PharmacistInformation> {
  File? image;

  @override
  void initState() {
    super.initState();
  }

  void loadImage() async {
    final imagePath = await SharedPrefHelper.getString(
      SharedPrefKeys.profileImage +
          context.read<ProfileCubit>().state.pharmacistModel!.nationalId,
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
              context.read<ProfileCubit>().state.pharmacistModel!.nationalId,
          pickedFile.path,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state.status == ProfileStatus.success) {}
        if (state.status == ProfileStatus.error) {}
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                icon: const Icon(FontAwesomeIcons.rightFromBracket),
                onPressed: () async {
                  await context.read<AuthCubit>().logout().then((_) {
                    context.read<AuthCubit>().onAuthReset();
                  });
                  SharedPrefHelper.remove(SharedPrefKeys.token);
                  SharedPrefHelper.remove(SharedPrefKeys.userType);
                  GoRouter.of(context).go(RoutesApp.login);
                },
              ),
            ],
            title: Text("Pharmacist Profile"),
            leading: ThemeButton(),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: image != null
                            ? FileImage(image!)
                            : const AssetImage("assets/images/doctor.jpeg")
                                  as ImageProvider,
                      ),
                      CircleAvatar(
                        radius: 18,
                        child: IconButton(
                          onPressed: pickImage,
                          icon: const Icon(Icons.camera_alt, size: 18),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    state.pharmacistModel?.fullName.toUpperCase() ?? "",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.titleLarge!.color,
                    ),
                  ),
                  Divider(height: 40, thickness: 2),
                  CustomListTile(
                    headline: state.pharmacistModel?.phoneNumber ?? "",
                    icon: FontAwesomeIcons.phone,
                  ),
                  CustomListTile(
                    headline: state.pharmacistModel?.email ?? "",
                    icon: FontAwesomeIcons.envelope,
                  ),
                  CustomListTile(
                    headline: state.pharmacistModel?.address ?? "",
                    icon: FontAwesomeIcons.locationDot,
                  ),
                  CustomListTile(
                    headline: state.pharmacistModel?.birthday ?? "",
                    icon: FontAwesomeIcons.birthdayCake,
                  ),
                  CustomListTile(
                    headline: state.pharmacistModel?.gender ?? "",
                    icon:
                        state.pharmacistModel?.gender?.toLowerCase() == "female"
                        ? FontAwesomeIcons.venus
                        : FontAwesomeIcons.mars,
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
