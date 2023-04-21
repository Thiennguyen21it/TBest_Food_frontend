import 'package:food_delivery/Data/api/api_client.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationRepo {
  final ApitClient apitClient;
  final SharedPreferences sharedPreferences;
  LocationRepo({required this.apitClient, required this.sharedPreferences});
}
