import 'package:food_delivery/Data/api/api_client.dart';

import '../../utils/constants/app_constants.dart';
import 'package:get/get.dart';

class UserRepo {
  final ApitClient apitClient;

  UserRepo({required this.apitClient});

  Future<Response> getUserInfo() async {
    return await apitClient.getData(
      AppConstants.USER_INFO_URI,
    );
  }
}
