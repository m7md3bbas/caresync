import 'package:caresync/controller/pharmacist/get_pharmacy_cubit.dart';
import 'package:caresync/controller/pharmacist/getall_pharmacy_state.dart';
import 'package:caresync/views/doctor/widgets/custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NearestPharmacy extends StatelessWidget {
  const NearestPharmacy({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetPharmacyCubit, GetallPharmacyState>(
      listener: (context, state) {
        if (state.status == GetallPharmacyStatus.error) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }
        if (state.status == GetallPharmacyStatus.success) {}
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text("Pharmacy"), centerTitle: true),
          body: state.status == GetallPharmacyStatus.loading
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                  onRefresh: () =>
                      context.read<GetPharmacyCubit>().getPharmacy(),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.pharmacies?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      final current = state.pharmacies![index];
                      return Card(
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomListTile(
                                headline: current.fullName,
                                icon: Icons.person,
                              ),
                              CustomListTile(
                                headline: current.pharmacyName,
                                icon: Icons.local_pharmacy,
                              ),
                              CustomListTile(
                                headline: current.pharmacyAddress,
                                icon: Icons.location_on,
                              ),
                              CustomListTile(
                                headline: current.phoneNumber,
                                icon: Icons.phone,
                              ),
                              CustomListTile(
                                headline: current.email,
                                icon: Icons.email,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
        );
      },
    );
  }
}
