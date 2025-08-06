import 'package:cached_network_image/cached_network_image.dart';
import 'package:caresync/controller/pharmacist/get_pharmacy_cubit.dart';
import 'package:caresync/controller/pharmacist/getall_pharmacy_state.dart';
import 'package:caresync/core/widget/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class NearestPharmacy extends StatelessWidget {
  const NearestPharmacy({super.key});
  Future<void> _makePhoneCall(BuildContext context, String phoneNumber) async {
    try {
      var status = await Permission.phone.status;
      if (!status.isGranted) {
        status = await Permission.phone.request();
      }

      if (status.isGranted) {
        final url = 'tel:$phoneNumber';
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(Uri.parse(url));
        } else {
          ToastHelper.showError('unable to make phone call');
        }
      } else {
        ToastHelper.showError('Permission not granted');
      }
    } catch (e) {
      ToastHelper.showError(e.toString());
    }
  }

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
                        elevation: 4,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(
                            color: Colors.grey.shade200,
                            width: 1,
                          ),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://reaikvslnvtzdllrrong.supabase.co/storage/v1/object/public/images/pojectImages/pharmacy.jpeg',
                                height: 150,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, error, stackTrace) =>
                                    const Center(child: Icon(Icons.error)),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 6,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Flexible(
                                    flex: 5,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            current.pharmacyName,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            children: [
                                              const Icon(
                                                FontAwesomeIcons.user,
                                                size: 16,
                                              ),
                                              const SizedBox(width: 8),
                                              Expanded(
                                                child: Text(current.fullName),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.verified,
                                                size: 16,
                                              ),
                                              const SizedBox(width: 8),
                                              Expanded(child: Text("verified")),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            children: [
                                              const Icon(
                                                FontAwesomeIcons.phone,
                                                size: 16,
                                              ),
                                              const SizedBox(width: 8),
                                              Expanded(
                                                child: Text(
                                                  current.phoneNumber,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: GestureDetector(
                                      onTap: () => _makePhoneCall(
                                        context,
                                        current.phoneNumber,
                                      ),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.green,
                                          borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(15),
                                          ),
                                        ),
                                        height: double.infinity,
                                        child: const Center(
                                          child: Icon(
                                            Icons.call,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
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

class CustomPharmacyCard extends StatelessWidget {
  const CustomPharmacyCard({
    required this.pharmacyName,
    required this.icon,
    super.key,
  });
  final String pharmacyName;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon),
          const SizedBox(width: 18),
          Text(pharmacyName, style: Theme.of(context).textTheme.headlineSmall),
        ],
      ),
    );
  }
}
