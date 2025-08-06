import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:caresync/controller/doctor/get_doctor_cubit.dart';
import 'package:caresync/controller/doctor/get_doctor_state.dart';
import 'package:caresync/core/colors/color_manager.dart';
import 'package:caresync/core/shared_prefs/shared_pref_helper.dart';
import 'package:caresync/core/shared_prefs/shared_pref_keys.dart';
import 'package:caresync/models/get_doctors.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DoctorListWidget extends StatefulWidget {
  final Function(GetDoctorModel) onDoctorSelect;

  const DoctorListWidget({Key? key, required this.onDoctorSelect})
    : super(key: key);

  @override
  State<DoctorListWidget> createState() => _DoctorListWidgetState();
}

class _DoctorListWidgetState extends State<DoctorListWidget> {
  String searchTerm = '';
  String selectedSpecialization = '';
  List<String> specializations = [];

  static const defaultDoctorImage =
      "https://reaikvslnvtzdllrrong.supabase.co/storage/v1/object/public/images/pojectImages/doctor.jpeg";

  @override
  void initState() {
    super.initState();
    _loadDoctors();
  }

  Future<void> _loadDoctors() async {
    try {
      final token = SharedPrefHelper.getString(SharedPrefKeys.token) ?? '';
      context.read<GetDoctorsCubit>().fetchDoctors(token);
    } catch (e) {
      Fluttertoast.showToast(msg: 'Failed to load doctors: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetDoctorsCubit, GetDoctorsState>(
      listener: (context, state) {
        if (state.status == GetDoctorsStatus.error) {
          Fluttertoast.showToast(
            msg: 'Failed to load doctors: ${state.errorMessage}',
          );
        }
        if (state.status == GetDoctorsStatus.success && state.doctors != null) {
          specializations = state.doctors!
              .map((d) => d.specialization)
              .where((s) => s.isNotEmpty)
              .toSet()
              .toList();
        }
      },
      builder: (context, state) {
        if (state.status == GetDoctorsStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status == GetDoctorsStatus.success && state.doctors != null) {
          final filteredDoctors = _filterDoctors(state.doctors!);
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFilters(),
                const SizedBox(height: 24),
                if (filteredDoctors.isEmpty)
                  _buildNoDoctorsFound()
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredDoctors.length,
                    itemBuilder: (context, index) =>
                        _buildDoctorCard(filteredDoctors[index]),
                  ),
                if (filteredDoctors.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      'Showing ${filteredDoctors.length} of ${state.doctors!.length} doctors',
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ),
              ],
            ),
          );
        }

        return const Center(child: Text('No doctors available'));
      },
    );
  }

  List<GetDoctorModel> _filterDoctors(List<GetDoctorModel> doctors) {
    return doctors.where((doctor) {
      final lowerSearch = searchTerm.toLowerCase();
      final matchesSearch =
          searchTerm.isEmpty ||
          doctor.fullName.toLowerCase().contains(lowerSearch) ||
          doctor.specialization.toLowerCase().contains(lowerSearch) ||
          doctor.hospital.toLowerCase().contains(lowerSearch) ||
          doctor.clinic.toLowerCase().contains(lowerSearch);

      final matchesSpecialization =
          selectedSpecialization.isEmpty ||
          doctor.specialization == selectedSpecialization;

      return matchesSearch && matchesSpecialization;
    }).toList();
  }

  Widget _buildFilters() {
    return Column(
      children: [
        TextField(
          onChanged: (value) => setState(() => searchTerm = value),
          decoration: InputDecoration(
            hintText: 'Search by name, specialization, hospital...',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          value: selectedSpecialization.isEmpty ? null : selectedSpecialization,
          decoration: InputDecoration(
            labelText: 'Specialization',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          items: [
            const DropdownMenuItem(
              value: '',
              child: Text('All Specializations'),
            ),
            ...specializations.map(
              (spec) => DropdownMenuItem(value: spec, child: Text(spec)),
            ),
          ],
          onChanged: (value) =>
              setState(() => selectedSpecialization = value ?? ''),
        ),
      ],
    );
  }

  Widget _buildDoctorCard(GetDoctorModel doctor) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => widget.onDoctorSelect(doctor),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: ColorManager.primary,
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: defaultDoctorImage,
                    fit: BoxFit.cover,
                    width: 60,
                    height: 60,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(child: _buildDoctorInfo(doctor)),
              ElevatedButton.icon(
                onPressed: () => widget.onDoctorSelect(doctor),
                icon: const Icon(Icons.arrow_forward, size: 16),
                label: const Text('Select'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDoctorInfo(GetDoctorModel doctor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dr. ${doctor.fullName}',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        if (doctor.specialization.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              doctor.specialization,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ),
        _buildDoctorDetails(doctor),
      ],
    );
  }

  Widget _buildDoctorDetails(GetDoctorModel doctor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (doctor.hospital.isNotEmpty)
          _buildDetailItem(Icons.local_hospital, doctor.hospital),
        if (doctor.clinic.isNotEmpty)
          _buildDetailItem(Icons.business, doctor.clinic),
        _buildDetailItem(Icons.phone, doctor.phoneNumber),
        _buildDetailItem(Icons.email, doctor.email),
      ],
    );
  }

  Widget _buildDetailItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Row(
        children: [
          Icon(icon, size: 14, color: Colors.grey),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoDoctorsFound() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Column(
          children: const [
            Icon(Icons.person_off, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No doctors found',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Try adjusting your search criteria or check back later.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
