import 'package:food_delivery/Data/api/api_client.dart';
import 'package:food_delivery/models/signup_body_model.dart';
import 'package:food_delivery/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final ApitClient apitClient;
  //save token in shared preference
  final SharedPreferences sharedPreferences;

  //contructor
  AuthRepo({required this.apitClient, required this.sharedPreferences});

  //create post method
  Future<Response> registration(SignUpBody signUpBody) async {
    return await apitClient.postData(
        AppConstants.REGISTRATION_URI, signUpBody.toJson());
  }

  Future<Response> login(String phone, String password) async {
    return await apitClient.postData(
        AppConstants.LOGIN_URI, {"phone": phone, "password": password});
  }

  Future<String> getUserToken() async {
    return sharedPreferences.getString(AppConstants.TOKEN) ?? "None";
  }

  //save user token in shared preference
  Future<bool> saveUserToken(String token) async {
    apitClient.token = token;
    apitClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  Future<void> saveUserNumberAndPassword(String number, String password) async {
    try {
      await sharedPreferences.setString(AppConstants.PHONE, number);
      await sharedPreferences.setString(AppConstants.PASSWORD, password);
    } catch (e) {
      e.toString();
    }
  }
}
