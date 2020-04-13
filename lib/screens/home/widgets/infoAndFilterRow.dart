import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/viewModels/subjectVM.dart';

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
  String dropdownValue = 'Priority';

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, SubjectVM subjectVM, child) {
        if (subjectVM.subjectList.isEmpty) {
          return Container();
        } else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "today's to-do",
                  style: Theme.of(context)
                      .textTheme
                      .display2
                      .copyWith(fontSize: 24),
                ),
              ),
              DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: dropdownValue,
                  icon: Icon(Icons.sort),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: widget.blue),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                  items: <String>['Priority', 'End Date', 'New', 'Old']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              )
            ],
          );
        }
      },
    );
  }
}
