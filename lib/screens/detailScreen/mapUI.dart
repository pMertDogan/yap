import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/data/models/subject.dart';
import 'package:todo/state/detailVM.dart';

class MapUI extends StatelessWidget {
  const MapUI({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: StateBuilder<DetailVM>(
      tag: "maps",
      observe: () => RM.get<DetailVM>(),
      child: Container(),
      builderWithChild: (context, model, child) {
        final Subject subject = model.state.subject;
        return subject.latLngList[0] == null
            ? child
            : Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      subject.locationName,
                      style: Theme.of(context)
                          .textTheme
                          .headline3
                          .copyWith(fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      child: FlutterMap(
                        mapController: RM.get<DetailVM>().state.mapController,
                        options: new MapOptions(
                          center: LatLng(
                              subject.latLngList[0], subject.latLngList[1]),
                          zoom: 15.0,
                          //onTap: (x) => buildLocationSelect(context),
                        ),
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
                                point: LatLng(subject.latLngList[0],
                                    subject.latLngList[1]),
                                builder: (ctx) => new Container(
                                  child: new Icon(Icons.location_on),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
      },
    ));
  }
}
