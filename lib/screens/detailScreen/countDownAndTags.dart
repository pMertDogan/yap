import 'package:flutter/material.dart';
import 'package:todo/data/models/subject.dart';
import 'package:todo/utility/colors.dart';
import 'package:todo/widgets/countDown.dart';

class CountdownAndTags extends StatelessWidget {
  const CountdownAndTags({
    Key key,
    @required this.subject,
  }) : super(key: key);

  final Subject subject;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 7,
      right: 30,
      height: 30,
      width: MediaQuery.of(context).size.width - 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CountDown(
            subject: subject,
            heightPercent: 1,
          ),
          ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: subject.tags.length + 1,
              itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: FilterChip(
                      backgroundColor: UIColors.chipsColor,
                      label: Text(
                        index == 0 ? "+" : subject.tags.elementAt(index - 1),
                        style: TextStyle(color: Colors.white),
                      ),
                      onSelected: (bool value) {},
                    ),
                  ))
        ],
      ),
    );
  }
}
