import 'package:food_delivery/base/show_custom_snackbar.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class ApiChecker {
  static void checkApi(Response response) {
    if (response.statusCode == 401) {
      //logout
      Get.offAllNamed(RouteHelper.getSignInPage());
    } else {
      //show error
      // showCustomSnackBar(response.statusText!);
    }
  }
}
