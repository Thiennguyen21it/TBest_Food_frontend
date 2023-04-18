import 'package:food_delivery/Data/repository/user_repo.dart';
import 'package:food_delivery/models/response_model.dart';
import 'package:food_delivery/models/signup_body_model.dart';
import 'package:food_delivery/models/user_models.dart';
import 'package:get/get.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;

  UserController({required this.userRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  late UserModel _userModel;
  UserModel get userModel => _userModel;

  Future<ResponseModel> getUserInfor() async {
    Response response = await userRepo.getUserInfo();
    late ResponseModel responseModel;
    print("test " + response.body.toString());
    if (response.statusCode == 200) {
      _userModel = UserModel.fromJson(response.body);
      _isLoading = true;
      responseModel = ResponseModel(true, "successfullly");
    } else {
      print("did not get");
      responseModel = ResponseModel(false, response.statusText!);
    }
    update();
    return responseModel;
  }
}
