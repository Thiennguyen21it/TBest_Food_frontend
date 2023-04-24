import 'package:flutter/material.dart';
import 'package:food_delivery/Controllers/auth_controller.dart';
import 'package:food_delivery/Controllers/location_controller.dart';
import 'package:food_delivery/Controllers/user_controller.dart';
import 'package:food_delivery/utils/constants/color_constants.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAdressPage extends StatefulWidget {
  const AddAdressPage({super.key});

  @override
  State<AddAdressPage> createState() => _AddAdressPageState();
}

class _AddAdressPageState extends State<AddAdressPage> {
  TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();

  late bool _isLogged;
  CameraPosition _cameraPosition = const CameraPosition(
    target: LatLng(23.8103, 90.4125),
    zoom: 17,
  );
  late LatLng _initialPositon = LatLng(45.51563, -122.677433);

  @override
  void initState() {
    super.initState();
    _isLogged = Get.find<AuthController>().userIsLoggedIn();
    if (_isLogged && Get.find<UserController>().userModel == null) {
      Get.find<UserController>().getUserInfor();
    }
    if (Get.find<LocationController>().addressList.isNotEmpty) {
      _cameraPosition = CameraPosition(
          target: LatLng(
              double.parse(
                  Get.find<LocationController>().getAddress["latitude"]),
              double.parse(
                  Get.find<LocationController>().getAddress["longitude"])));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Address"),
          backgroundColor: AppColors.mainColor,
        ),
        body: GetBuilder<LocationController>(
          builder: (locationController) {
            return Column(children: [
              Container(
                height: 140,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Theme.of(context).primaryColor),
                ),
                child: GoogleMap(
                  initialCameraPosition:
                      CameraPosition(target: _initialPositon, zoom: 17),
                  zoomControlsEnabled: false,
                  compassEnabled: false,
                  indoorViewEnabled: true,
                  mapToolbarEnabled: false,
                  onCameraIdle: () {
                    // print("camera idle");
                    locationController.updatePosition(_cameraPosition, true);
                  },
                  onCameraMove: ((position) => _cameraPosition = position),
                  onMapCreated: (GoogleMapController controller) {
                    locationController.setMapController(controller);
                  },
                ),
              )
            ]);
          },
        ));
  }
}
