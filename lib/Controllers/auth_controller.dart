import 'dart:math';

import 'package:food_delivery/Data/repository/auth_repo.dart';
import 'package:food_delivery/models/response_model.dart';
import 'package:food_delivery/models/signup_body_model.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;

  AuthController({required this.authRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  //registaion method
  Future<ResponseModel> registration(SignUpBody signUpBody) async {
    _isLoading = true;
    update();
    Response response = await authRepo.registration(signUpBody);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body['token']);
      responseModel = ResponseModel(true, response.body['token']);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  //login method
  Future<ResponseModel> login(String phone, String password) async {
    authRepo.getUserToken();
    _isLoading = true;
    update();
    Response response = await authRepo.login(phone, password);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      print("backend token");
      authRepo.saveUserToken(response.body['token']);
      print(response.body['token'].toString());
      responseModel = ResponseModel(true, response.body['token']);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  bool userIsLoggedIn() {
    return authRepo.userIsLoggedIn();
  }

  //save user number and password
  void saveUserNumberAndPassword(String number, String password) {
    authRepo.saveUserNumberAndPassword(number, password);
  }

  //clear shared data
  void clearSharedData() {
    authRepo.clearSharedData();
  }
}
