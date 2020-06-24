import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_mapbox_autocomplete/flutter_mapbox_autocomplete.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/state/detailVM.dart';
import 'package:todo/utility/apiKeys.dart';
import 'package:todo/utility/colors.dart';

class MiddleButtons extends StatelessWidget {
  const MiddleButtons({
    Key key,
  }) : super(key: key);

  void buildLocationSelect(BuildContext context) {
    showDialog(
      context: context,
      child: MapBoxAutoCompleteWidget(
        apiKey: ApiKeys.mapBoxToken,
        hint: "Select starting point",
        onSelect: (place) {
          double lat = place.geometry.coordinates[1],
              lng = place.geometry.coordinates[0];
          RM.get<DetailVM>().setState((s) async {
            await s.updateLocation(lat, lng, place.placeName);
          }, filterTags: ["maps"]);
        },
        limit: 10,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(36))),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton.icon(
                    onPressed: () {},
                    icon:
                        Icon(FlutterIcons.message1_ant, color: UIColors.purple),
                    label: Text(
                      "Message",
                      style: TextStyle(fontSize: 20, color: UIColors.purple),
                    ),
                  ),
                  SizedBox(
                    width: 70,
                  ),
                  FlatButton.icon(
                      onPressed: () {},
                      icon:
                          Icon(FlutterIcons.bell_faw5, color: UIColors.purple),
                      label: Text("Reminder",
                          style:
                              TextStyle(fontSize: 20, color: UIColors.purple)))
                ],
              ),
            ),
            InkWell(
              onTap: () => buildLocationSelect(context),
              child: CircleAvatar(
                radius: 35,
                backgroundColor: UIColors.purple,
                child: Icon(
                  FlutterIcons.edit_location_mdi,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
