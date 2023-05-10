import 'package:flutter/material.dart';
import 'package:food_delivery/Controllers/auth_controller.dart';
import 'package:food_delivery/Controllers/location_controller.dart';
import 'package:food_delivery/Controllers/user_controller.dart';
import 'package:food_delivery/models/address_model.dart';
import 'package:food_delivery/pages/address/pick_address_map.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/constants/color_constants.dart';
import 'package:food_delivery/utils/constants/dimension.dart';
import 'package:food_delivery/widgets/app_text_field.dart';
import 'package:food_delivery/widgets/big_text.dart';
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
  late LatLng _initialPositon = const LatLng(16.054407, 108.202164);

  @override
  void initState() {
    super.initState();
    _isLogged = Get.find<AuthController>().userIsLoggedIn();
    if (_isLogged && Get.find<UserController>().userModel == null) {
      Get.find<UserController>().getUserInfor();
    }
    if (Get.find<LocationController>().addressList.isNotEmpty) {
      if (Get.find<LocationController>().getUserAddressFromLocalStorage() ==
          "") {
        Get.find<LocationController>()
            .saveUserAddress(Get.find<LocationController>().addressList.last);
      }

      Get.find<LocationController>().getUserAddress();
      _cameraPosition = CameraPosition(
          target: LatLng(
              double.parse(
                  Get.find<LocationController>().getAddress["latitude"]),
              double.parse(
                  Get.find<LocationController>().getAddress["longitude"])));
      _initialPositon = LatLng(
          double.parse(Get.find<LocationController>().getAddress["latitude"]),
          double.parse(Get.find<LocationController>().getAddress["longitude"]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Address"),
        backgroundColor: AppColors.mainColor,
      ),
      body: GetBuilder<UserController>(
        builder: (userController) {
          if (userController.userModel != null &&
              _contactPersonName.text.isEmpty) {
            _contactPersonName.text = '${userController.userModel?.name}';
            _contactPersonNumber.text = '${userController.userModel?.phone}';
            if (Get.find<LocationController>().addressList.isNotEmpty) {
              _addressController.text =
                  Get.find<LocationController>().getUserAddress().address;
            }
          }
          return GetBuilder<LocationController>(
            builder: (locationController) {
              _addressController.text =
                  '${locationController.placemark.name ?? ''}'
                  '${locationController.placemark.locality ?? ''}'
                  '${locationController.placemark.postalCode ?? ''}'
                  '${locationController.placemark.country ?? ''}';
              print("address in my views : ${_addressController.text}");
              return SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 140,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border:
                              Border.all(color: AppColors.mainColor, width: 2),
                        ),
                        child: GoogleMap(
                          initialCameraPosition:
                              CameraPosition(target: _initialPositon, zoom: 17),
                          onTap: (LatLng) {
                            Get.toNamed(RouteHelper.getPickAddressPage(),
                                arguments: PickAddressMap(
                                  fromSignup: true,
                                  fromAddress: true,
                                  googleMapController:
                                      locationController.mapController,
                                ));
                          },
                          zoomControlsEnabled: false,
                          compassEnabled: false,
                          indoorViewEnabled: true,
                          mapToolbarEnabled: false,
                          myLocationEnabled: true,
                          onCameraIdle: () {
                            print("camera idle : ");
                            locationController.updatePosition(
                                _cameraPosition, true);
                          },
                          onCameraMove: ((position) =>
                              _cameraPosition = position),
                          onMapCreated: (GoogleMapController controller) {
                            locationController.setMapController(controller);
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: Dimensions.width20, top: Dimensions.height20),
                        child: SizedBox(
                          height: 50,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  locationController.addressTypeList.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    locationController
                                        .setAddressTypeIndex(index);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: Dimensions.width20,
                                        vertical: Dimensions.height10),
                                    margin: EdgeInsets.only(
                                        right: Dimensions.width10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radius20 / 4),
                                        color: Theme.of(context).cardColor,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey[200]!,
                                            spreadRadius: 1,
                                            blurRadius: 5,
                                          )
                                        ]),
                                    child: Icon(
                                      index == 0
                                          ? Icons.home_filled
                                          : index == 1
                                              ? Icons.work
                                              : Icons.location_on,
                                      color:
                                          locationController.addressTypeIndex ==
                                                  index
                                              ? AppColors.mainColor
                                              : Theme.of(context).disabledColor,
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: Dimensions.width20),
                        child: const BigText(text: "Delivery Address"),
                      ),
                      SizedBox(height: Dimensions.height20),
                      AppTextField(
                        textController: _addressController,
                        hintText: 'Your Address',
                        icon: Icons.map,
                        iconColor: AppColors.mainColor,
                        obscureText: false,
                      ),
                      SizedBox(height: Dimensions.height20),
                      Padding(
                        padding: EdgeInsets.only(left: Dimensions.width20),
                        child: const BigText(text: "Contact Name "),
                      ),
                      SizedBox(height: Dimensions.height10),
                      AppTextField(
                        textController: _contactPersonName,
                        hintText: 'Your name',
                        icon: Icons.person,
                        iconColor: AppColors.mainColor,
                        obscureText: false,
                      ),
                      SizedBox(height: Dimensions.height20),
                      Padding(
                        padding: EdgeInsets.only(left: Dimensions.width20),
                        child: const BigText(text: "Your Number"),
                      ),
                      SizedBox(height: Dimensions.height10),
                      AppTextField(
                        textController: _contactPersonNumber,
                        hintText: 'Your phone number',
                        icon: Icons.phone,
                        iconColor: AppColors.mainColor,
                        obscureText: false,
                      ),
                    ]),
              );
            },
          );
        },
      ),
      bottomNavigationBar: GetBuilder<LocationController>(
        builder: (locationController) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: Dimensions.height20 * 8,
                padding: EdgeInsets.only(
                    top: Dimensions.height30,
                    left: Dimensions.width20,
                    right: Dimensions.width20),
                decoration: BoxDecoration(
                  color: AppColors.buttonBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius30),
                    topRight: Radius.circular(Dimensions.radius30),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        AddressModel _addressModel = AddressModel(
                            addressType: locationController.addressTypeList[
                                locationController.addressTypeIndex],
                            address: _addressController.text,
                            contactPersonName: _contactPersonName.text,
                            contactPersonNumber: _contactPersonNumber.text,
                            latitude:
                                locationController.position.latitude.toString(),
                            longitude: locationController.position.longitude
                                .toString());

                        locationController
                            .addAddress(_addressModel)
                            .then((respone) {
                          if (respone.isSuccess) {
                            Get.toNamed(RouteHelper.getInitial());
                            Get.snackbar("Address", "Added Successfully",
                                backgroundColor: AppColors.mainColor);
                          } else {
                            Get.snackbar("Address", "Failed to add address",
                                backgroundColor: Colors.red);
                          }
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          top: Dimensions.height15,
                          bottom: Dimensions.height15,
                          left: Dimensions.width15,
                          right: Dimensions.width15,
                        ),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                          color: AppColors.mainColor,
                        ),
                        child: const BigText(
                          text: "Save Address",
                          color: Colors.white,
                          size: 26,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
