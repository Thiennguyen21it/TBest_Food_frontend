import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery/Controllers/auth_controller.dart';
import 'package:food_delivery/Controllers/location_controller.dart';
import 'package:food_delivery/Controllers/user_controller.dart';
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
  final CameraPosition _cameraPosition = const CameraPosition(
    target: LatLng(23.8103, 90.4125),
    zoom: 17,
  );
  late LatLng _initialPositon;

  @override
  void initState() {
    super.initState();
    _isLogged = Get.find<AuthController>().userIsLoggedIn();
    if (_isLogged && Get.find<UserController>().userModel==null) {
      Get.find<UserController>().getUserInfor();
    }
    if(Get.find<LocationController>().addressList.isNotEmpty) {
      
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Address"),
      ),
    );
  }
}
