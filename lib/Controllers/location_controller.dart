import 'package:food_delivery/Data/repository/location_repo.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/address_model.dart';

class LocationController extends GetxController implements GetxService {
  final LocationRepo locationRepo;
  LocationController({required this.locationRepo});

  bool _loading = false;
  late Position _position;
  late Position _pickPosition;

  Placemark _placemark = Placemark();
  Placemark _pickPlacemark = Placemark();

  List<AddressModel> _addressList = [];
  List<AddressModel> get addressList => _addressList;
  late List<AddressModel> _allAddressList;
  List<String> _addressTypeList = [
    "Home",
    "Office",
    "Other",
  ];
  int _addressTypeIndex = 0;
  late Map<String, dynamic> _getAddress;
  Map get getAddress => _getAddress;
  bool _updateAddressData = true;
  bool _changeAddress = true;

  late GoogleMapController _mapController;

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
        if (_changeAddress) {
          String _address = await getAddressFromGeocode(
              LatLng(position.target.latitude, position.target.longitude));
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }

  Future<String> getAddressFromGeocode(LatLng latlng) async {
    String _address = "Unknow Location Found";
    Response response = await locationRepo.getAddressFromGeocode(latlng);
    return _address;
  }
}
