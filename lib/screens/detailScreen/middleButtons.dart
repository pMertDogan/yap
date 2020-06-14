import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:todo/utility/colors.dart';

class MiddleButtons extends StatelessWidget {
  const MiddleButtons({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            Stack(alignment: Alignment.center, children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.all(Radius.circular(36))),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton.icon(
                    onPressed: () {},
                    icon: Icon(FlutterIcons.message1_ant,
                        color: UIColors.purple),
                    label: Text(
                      "Message",
                      style: TextStyle(
                          fontSize: 20, color: UIColors.purple),
                    )),
                SizedBox(
                  width: 70,
                ),
                FlatButton.icon(
                  
                    onPressed: () {},
                    icon: Icon(FlutterIcons.bell_faw5,
                        color: UIColors.purple),
                    label: Text("Reminder", 
                        style: TextStyle(
                            fontSize: 20,
                            color: UIColors.purple)))
              ],
            ),
          ),
          CircleAvatar(
            radius: 35,
            backgroundColor: UIColors.darkerPurple,
            child: Icon(
              FlutterIcons.edit_location_mdi,
              size: 40,
            ),
          ),
        ]),
      ),
    );
  }
}