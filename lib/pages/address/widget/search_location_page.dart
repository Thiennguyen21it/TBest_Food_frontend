import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:food_delivery/utils/constants/dimension.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import '../../../Controllers/location_controller.dart';

class LocationDialogue extends StatelessWidget {
  final GoogleMapController mapController;

  const LocationDialogue({super.key, required this.mapController});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    return Container(
      padding: EdgeInsets.all(Dimensions.width10),
      alignment: Alignment.topCenter,
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius20 / 2),
        ),
        child: SizedBox(
          width: Dimensions.screenWidth,
          child: TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
                controller: _controller,
                textInputAction: TextInputAction.search,
                autofocus: true,
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.streetAddress,
                decoration: InputDecoration(
                  hintText: "search location",
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(Dimensions.radius20 / 2),
                    borderSide: const BorderSide(
                      style: BorderStyle.none,
                      width: 0,
                    ),
                  ),
                  hintStyle: Theme.of(context).textTheme.headline2?.copyWith(
                      color: Theme.of(context).disabledColor,
                      fontSize: Dimensions.font16),
                )),
            onSuggestionSelected: (Prediction suggestion) {
              //as we typed , it will give a suggestion
              Get.find<LocationController>().setLocation(
                  suggestion.placeId!, suggestion.description!, mapController);
              Get.back();
            },
            suggestionsCallback: (pattern) async {
              return await Get.find<LocationController>()
                  .searchLocation(context, pattern);
            },
            itemBuilder: (context, Prediction suggestion) {
              return Padding(
                padding: EdgeInsets.all(Dimensions.width10),
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                    ),
                    Expanded(
                        child: Text(suggestion.description!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .headline2
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        ?.color,
                                    fontSize: Dimensions.font16)))
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
