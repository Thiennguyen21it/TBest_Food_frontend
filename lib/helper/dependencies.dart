import 'package:food_delivery/Data/api/api_client.dart';
import 'package:get/get.dart';

Future<void> init() async {
  Get.lazyPut(
    (() => ApitClient(appBaseUrl: "https://ww..vku.com")),
  );
}
