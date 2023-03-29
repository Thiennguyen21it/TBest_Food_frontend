import 'package:food_delivery/utils/constants/app_constants.dart';
import 'package:get/get.dart';

//write api method(function) here

class ApitClient extends GetConnect implements GetxService {
  // late String token;
  // final String appBaseUrl; //server url
  // late Map<String, String> _mainHeader;
  // ApitClient({required this.appBaseUrl}) {
  //   baseUrl = appBaseUrl;
  //   timeout = const Duration(seconds: 30);
  //   _mainHeader = {
  //     'Contents-type': 'application/json; charset=UTF-8',
  //     'Authorization': 'Bearer $token',
  //   };
  // }
  late String token;
  final String appBaseUrl; //server url
  late Map<String, String> _mainHeaders;
  ApitClient({required this.appBaseUrl}) {
    // token = "Bearer " + Get.find<ApitClient>().token;
    baseUrl = appBaseUrl;
    timeout = const Duration(seconds: 30);
    token = AppConstants.TOKEN;
    _mainHeaders = {
      'Content-type': 'application/json;charset = UTF-8',
      'Authorization': 'Bearer $token',
    };
  }
  //create get api (get data from server)
  Future<Response> getData(String uri) async {
    try {
      Response response = await get(uri);
      return response;
    } catch (e) {
      return Response(statusText: e.toString(), statusCode: 1);
    }
  }
  //create post api (send data to server)
}
