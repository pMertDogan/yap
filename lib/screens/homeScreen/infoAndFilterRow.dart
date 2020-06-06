import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/state/subjectVM.dart';

class InfoAndFilterRow extends StatefulWidget {
  InfoAndFilterRow({
    Key key,
    @required this.blue,
  }) : super(key: key);

  final Color blue;

  @override
  _InfoAndFilterRowState createState() => _InfoAndFilterRowState();
}

class _InfoAndFilterRowState extends State<InfoAndFilterRow> {
  //String dropdownValue = 'Priority';

  @override
  Widget build(BuildContext context) {
    return StateBuilder<String>(
      observe: () => RM.create("Priority"),
      builder: (context, stringRM) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "today's to-do",
              style:
                  Theme.of(context).textTheme.headline3.copyWith(fontSize: 24),
            ),
          ),
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: stringRM.state,
              icon: Icon(Icons.sort),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: widget.blue),
              onChanged: (String selectedFilter) {
                stringRM.setState((s) => s = selectedFilter);
                RM.get<SubjectVM>().setState((s) async {
                  s.orderByParamater = stringRM.state;
                  await s.getSelectedDayData(filterByTags: true);
                });
              },
              items: <String>['Priority', 'End Date', 'Recent', 'Old']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}
