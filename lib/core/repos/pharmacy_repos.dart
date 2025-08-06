import 'dart:convert';
import 'package:caresync/core/internet/internet_connection.dart';
import 'package:caresync/core/service/pharmacist_service.dart';
import 'package:caresync/core/shared_prefs/shared_pref_helper.dart';
import 'package:caresync/core/shared_prefs/shared_pref_keys.dart';
import 'package:caresync/models/all_pharmacist_model.dart';

class PharmacyRepository {
  final PharmacistService service;
  final NetworkInfo networkInfo;

  PharmacyRepository(this.service, this.networkInfo);

  Future<List<SinglePharmacy>> getPharmacies({
    bool forceRefresh = false,
  }) async {
    final isConnected = await networkInfo.isConnected;

    if ((isConnected && !forceRefresh == false) || forceRefresh) {
      final pharmacies = await service.getPharmacistCategories();

      await SharedPrefHelper.setString(
        SharedPrefKeys.pharmacy,
        jsonEncode(pharmacies.map((e) => e.toJson()).toList()),
      );

      return pharmacies;
    }

    final cached = SharedPrefHelper.getString(SharedPrefKeys.pharmacy);
    if (cached != null) {
      final decoded = jsonDecode(cached) as List;
      return decoded.map((e) => SinglePharmacy.fromJson(e)).toList();
    } else {
      throw Exception("No internet and no cached pharmacies found.");
    }
  }
}
