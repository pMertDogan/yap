import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_mapbox_autocomplete/flutter_mapbox_autocomplete.dart';
import 'package:latlong/latlong.dart';

import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/state/subjectVM.dart';
import 'package:todo/ui/colors.dart';

LatLng _selectedLocation;
final ReactiveModel<SubjectVM> subjectVMRM =
    Injector.getAsReactive<SubjectVM>();
const String _mapBoxToken =
    "pk.eyJ1IjoiNzYzIiwiYSI6ImNrOTFwbnhsejAwNXQzbW95cmQ0d2FhODcifQ.xY0bazHg-e1aiLzS3jqJ6w";

final MapController _mapController = MapController();

class Location extends StatefulWidget {
  const Location({
    Key key,
  }) : super(key: key);

  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => buildLocationSelect(context),
      child: Container(
        height: subjectVMRM.value.latLngValues.isEmpty ? 70 : 250,
        child: StateBuilder(
          models: [subjectVMRM],
          builder: (context, _) {
            List<double> latLngList = subjectVMRM.value.latLngValues;

            if (latLngList.isNotEmpty) {
              _selectedLocation = LatLng(latLngList[0], latLngList[1]);
              print("selected lat lng " + _selectedLocation.toString());
            }
            return latLngList.isEmpty
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.edit_location,
                        size: 48,
                        color: UIColors.addSubjectSheetLightColor,
                      ),
                      Text(
                        "Add location",
                        style: Theme.of(context).textTheme.display1,
                      )
                    ],
                  )
                : Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          subjectVMRM.value.mapBoxPlace.placeName.toString() +
                              "\n",
                          style: Theme.of(context).textTheme.display1,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: FlutterMap(
                            mapController: _mapController,
                            options: new MapOptions(
                                center: _selectedLocation,
                                zoom: 15.0,
                                onTap: (x) => buildLocationSelect(context)),
                            layers: [
                              new TileLayerOptions(
                                  urlTemplate:
                                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                  subdomains: ['a', 'b', 'c']),
                              new MarkerLayerOptions(
                                markers: [
                                  new Marker(
                                    width: 80.0,
                                    height: 80.0,
                                    point: _selectedLocation,
                                    builder: (ctx) => new Container(
                                      child: new Icon(Icons.location_on),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
          },
        ),
      ),
    );
  }

  void buildLocationSelect(BuildContext context) {
    showDialog(
      context: context,
      child: MapBoxAutoCompleteWidget(
        apiKey: _mapBoxToken,
        hint: "Select starting point",
        onSelect: (place) {
          double lat = place.geometry.coordinates[1],
              lng = place.geometry.coordinates[0];

          subjectVMRM.setState((state) {
            print(place.placeName);
            if (state.mapBoxPlace != null) {
              _mapController.move(LatLng(lat, lng), 13);
            }
            state.mapBoxPlace = place;
            return state.latLngValues = <double>[lat, lng];
          });
        },
        limit: 10,
      ),
    );
  }
}
