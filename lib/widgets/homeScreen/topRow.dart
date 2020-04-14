import 'package:flutter/material.dart';

class TopRow extends StatelessWidget {
  const TopRow({
    Key key,
    @required this.blue,
    @required this.grey,
  }) : super(key: key);

  final Color blue;
  final Color grey;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
                color: blue,
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(8))),
            child: Icon(
              Icons.add_a_photo,
              size: 50,
              color: grey,
            )),
        Container(
          child: Text(
            "Welcome,userName",
            style: Theme.of(context).textTheme.display2.copyWith(fontSize: 25),
          ),
        ),
        Icon(
          Icons.settings,
          color: blue,
        )
      ],
    );
  }
}
