import 'package:food_delivery/Data/api/api_client.dart';
import 'package:food_delivery/models/address_model.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants/app_constants.dart';

class LocationRepo {
  final ApitClient apitClient;
  final SharedPreferences sharedPreferences;
  LocationRepo({required this.apitClient, required this.sharedPreferences});

  Future<Response> getAddressFromGeocode(LatLng latLng) async {
    return await apitClient.getData('${AppConstants.GEOCODE_URI}'
        '?lat=${latLng.latitude}&lng=${latLng.longitude}');
  }

  String getUserAddress() {
    return sharedPreferences.getString(AppConstants.USER_ADDRESS) ?? "";
  }

  Future<Response> addAddress(AddressModel addressModel) {
    return apitClient.postData(
        AppConstants.ADD_USER_ADDRESS, addressModel.toJson());
  }

  Future<Response> getAllAddress() {
    return apitClient.getData(AppConstants.ADDRESS_LIST_URI);
  }

  Future<bool> saveUserAddress(String address) {
    apitClient.updateHeader(sharedPreferences.getString(AppConstants.TOKEN)!);
    return sharedPreferences.setString(AppConstants.USER_ADDRESS, address);
  }

  Future<Response> getZone(String lat, String lng) async {
    return await apitClient
        .getData('${AppConstants.ZONE_URI}?lat=$lat&lng=$lng');
  }

  Future<Response> searchLocation(String text) async {
    return await apitClient
        .getData('${AppConstants.SEARCH_LOCATION_URI}?search_text=$text');
  }

  Future<Response> setLocation(String placeId) async {
    return await apitClient
        .getData('${AppConstants.PLACE_DETAILS_URI}?placeid=$placeId');
  }
}
