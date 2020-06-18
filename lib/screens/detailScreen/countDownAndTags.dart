import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:todo/data/models/subject.dart';
import 'package:todo/utility/colors.dart';
import 'package:todo/widgets/countDown.dart';
import 'package:todo/widgets/showAddTagsToSubjectSheet.dart';

class CountdownAndTagsRow extends StatelessWidget {
  const CountdownAndTagsRow({
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
          Expanded(
            flex: 2,
            child: CountDown(
              subject: subject,
              heightPercent: 1,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Expanded(
            flex: 2,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: subject.tags.length + 1,
                itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: FilterChip(
                        backgroundColor: UIColors.chipsColor,
                        label: index == 0
                            ? InkWell(
                                onTap: () => showAddTagSheet(subject),
                                child: Icon(
                                  FlutterIcons.add_mdi,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                subject.tags.elementAt(index - 1),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                        onSelected: (bool value) {},
                      ),
                    )),
          )
        ],
      ),
    );
  }
}
