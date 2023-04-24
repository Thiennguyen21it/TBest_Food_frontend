import 'package:food_delivery/Data/api/api_client.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants/app_constants.dart';

class LocationRepo {
  final ApitClient apitClient;
  final SharedPreferences sharedPreferences;
  LocationRepo({required this.apitClient, required this.sharedPreferences});

  Future<Response> getAddressFromGeocode(LatLng latLng) async {
    return await apitClient.getData("${AppConstants.GEOCODE_URI}"
        "?lat=${latLng.latitude}${latLng.longitude}");
  }
}
