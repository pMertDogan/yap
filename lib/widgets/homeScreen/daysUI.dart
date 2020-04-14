import 'package:flutter/material.dart';
import 'package:todo/ui/colors.dart';

class DaysUI extends StatelessWidget {
  const DaysUI({
    Key key,
    @required this.blue,
  }) : super(key: key);

  final Color blue;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 75,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemExtent: 125,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                    color: blue,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(8))),
                margin: EdgeInsets.all(4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 10),
                      child: Text(
                        "Buğün $index",
                        style: Theme.of(context)
                            .textTheme
                            .display1
                            .copyWith(fontSize: 21),
                      ),
                    ),
                    Container(
                      color: UIColors.todoOrange,
                      child: Padding(
                        padding: const EdgeInsets.all(3),
                        child: Text(
                          index.toString() + " todo's",
                          style: Theme.of(context).textTheme.display1,
                        ),
                      ),
                    )
                  ],
                ),
              );
            }));
  }
}
