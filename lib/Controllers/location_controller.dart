import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:food_delivery/Data/api/api_checker.dart';
import 'package:food_delivery/Data/repository/location_repo.dart';
import 'package:food_delivery/models/response_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

import '../models/address_model.dart';

class LocationController extends GetxController implements GetxService {
  final LocationRepo locationRepo;
  LocationController({required this.locationRepo});

  bool _loading = false;
  bool get loading => _loading;
  late Position _position;
  Position get position => _position;
  late Position _pickPosition;
  Position get pickPosition => _pickPosition;

  //for service zone
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  //whether user is in service zone or not
  bool _inZone = false;
  bool get inZone => _inZone;
  //showing and hiding the button as the map loads
  bool _buttonDisabled = true;
  bool get buttonDisabled => _buttonDisabled;

  /* 
  save the google map suggestion for address 
  

  */

  List<Prediction> _predictionList = [];

  Placemark _placemark = Placemark();
  Placemark get placemark => _placemark;
  Placemark _pickPlacemark = Placemark();
  Placemark get pickPlacemark => _pickPlacemark;

  List<AddressModel> _addressList = [];
  List<AddressModel> get addressList => _addressList;
  late List<AddressModel> _allAddressList;
  List<AddressModel> get allAddressList => _allAddressList;
  List<String> _addressTypeList = [
    "Home",
    "Office",
    "Other",
  ];
  List<String> get addressTypeList => _addressTypeList;
  int _addressTypeIndex = 0;
  int get addressTypeIndex => _addressTypeIndex;

  bool _updateAddressData = true;
  bool _changeAddress = true;

  late GoogleMapController _mapController;
  GoogleMapController get mapController => _mapController;

  void setMapController(GoogleMapController mapController) {
    _mapController = mapController;
  }

  void updatePosition(CameraPosition position, bool fromAddress) async {
    if (_updateAddressData) {
      _loading = true;
      update();
      try {
        if (fromAddress) {
          _position = Position(
            latitude: position.target.latitude,
            longitude: position.target.longitude,
            timestamp: DateTime.now(),
            heading: 1,
            accuracy: 1,
            speedAccuracy: 1,
            speed: 1,
            altitude: 1,
          );
        } else {
          _pickPosition = Position(
            latitude: position.target.latitude,
            longitude: position.target.longitude,
            timestamp: DateTime.now(),
            heading: 1,
            accuracy: 1,
            speedAccuracy: 1,
            speed: 1,
            altitude: 1,
          );
        }

        ResponseModel _responseModel = await getZone(
            position.target.latitude.toString(),
            position.target.longitude.toString(),
            false);
        //if button value is false then user is in service zone
        _buttonDisabled = !_responseModel.isSuccess;
        if (_changeAddress) {
          //talk to server
          print("touch to server");
          String _address = await getAddressFromGeocode(
            LatLng(position.target.latitude, position.target.longitude),
          );
          print("printing address" + _address);
          fromAddress
              ? _placemark = Placemark(name: _address)
              : _pickPlacemark = Placemark(name: _address);
        }
      } catch (e) {
        print(e.toString());
      }
      _loading = false;
      update();
    } else {
      _updateAddressData = true;
    }
  }

  Future<String> getAddressFromGeocode(LatLng latlng) async {
    String _address = "Unknow Location Found";

    Response response = await locationRepo.getAddressFromGeocode(latlng);

    if (response.body["status"] == 'OK') {
      _address = response.body["results"][0]["formatted_address"].toString();
      print("printing address" + _address);
    } else {
      print("Error gettting the google api ");
    }
    update();
    return _address;
  }

  late Map<String, dynamic> _getAddress;
  Map get getAddress => _getAddress;
  AddressModel getUserAddress() {
    late AddressModel _addressModel;
    //converting to map using json decode
    _getAddress = jsonDecode(locationRepo.getUserAddress());
    try {
      _addressModel =
          AddressModel.fromJson(jsonDecode(locationRepo.getUserAddress()));
    } catch (e) {
      print(e.toString());
    }
    return _addressModel;
  }

  void setAddressTypeIndex(int index) {
    _addressTypeIndex = index;
    update();
  }

  Future<ResponseModel> addAddress(AddressModel addressModel) async {
    _loading = true;
    update();
    Response response = await locationRepo.addAddress(addressModel);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      await getAddressList();
      String message = response.body["message"];
      responseModel = ResponseModel(true, message);
      //save user address to local storage
      await saveUserAddress(addressModel);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    update();
    return responseModel;
  }

  Future<void> getAddressList() async {
    Response response = await locationRepo.getAllAddress();
    if (response.statusCode == 200) {
      _addressList = [];
      _allAddressList = [];
      response.body.forEach((address) {
        _addressList.add(AddressModel.fromJson(address));
        _allAddressList.add(AddressModel.fromJson(address));
      });
    } else {
      _addressList = [];
      _allAddressList = [];
      print("Error getting address list");
    }
    update();
  }

  Future<bool> saveUserAddress(AddressModel addressModel) async {
    String userAddress = jsonEncode(addressModel.toJson());
    return await locationRepo.saveUserAddress(userAddress);
  }

  void clearAddressList() {
    _addressList = [];
    _allAddressList = [];
    update();
  }

  String getUserAddressFromLocalStorage() {
    return locationRepo.getUserAddress();
  }

  void setAddAddressData() {
    _position = _pickPosition;
    _placemark = _pickPlacemark;
    _updateAddressData = false;
    update();
  }

  Future<ResponseModel> getZone(String lat, String lng, bool markerLoad) async {
    late ResponseModel _responseModel;

    if (markerLoad) {
      _loading = true;
    } else {
      _isLoading = true;
    }
    update();
    Response response = await locationRepo.getZone(lat, lng);

    if (response.statusCode == 200) {
      _inZone = true;
      _responseModel = ResponseModel(true, response.body["zone_id"].toString());
    } else {
      _inZone = false;
      _responseModel = ResponseModel(true, response.statusText!);
    }
    print("zone response :" + response.statusCode.toString()); //200 , 404
    update();
    if (markerLoad) {
      _loading = false;
    } else {
      _isLoading = false;
    }
    update();
    return _responseModel;
  }

  Future<List<Prediction>> searchLocation(
      BuildContext context, String text) async {
    if (text.isNotEmpty) {
      Response response = await locationRepo.searchLocation(text);

      if (response.statusCode == 200 && response.body["status"] == "OK") {
        _predictionList = [];
        response.body["predictions"].forEach((prediction) {
          _predictionList.add(Prediction.fromJson(prediction));
        });
      } else {
        ApiChecker.checkApi(response);
      }
    }
    return _predictionList;
  }

  setLocation(
      String placeId, String address, GoogleMapController mapController) async {
    _loading = true;
    update();
    PlacesDetailsResponse detail;
    Response response = await locationRepo.setLocation(placeId);
    detail = PlacesDetailsResponse.fromJson(response.body);
    _pickPosition = Position(
      latitude: detail.result.geometry!.location.lat,
      longitude: detail.result.geometry!.location.lng,
      accuracy: 1,
      altitude: 1,
      heading: 1,
      speed: 1,
      speedAccuracy: 1,
      timestamp: DateTime.now(),
    );
    _pickPlacemark = Placemark(
      name: address,
    );
    _changeAddress = false;
    _loading = false;
    update();
  }
}
