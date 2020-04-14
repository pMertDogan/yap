import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:jiffy/jiffy.dart';
import 'package:todo/widgets/addSubjectSheet/addSubject.dart';
import 'package:todo/widgets/addSubjectSheet/titleText.dart';

DateTime savedDateTime;

class StartEndTimeLineUI extends StatelessWidget {
  const StartEndTimeLineUI({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            TitleText(
              padding: false,
              titleText: "Start",
            ),
            TitleText(
              padding: false,
              titleText: "End",
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        TimeLineSelect(),
      ],
    );
  }
}

class TimeLineSelect extends StatefulWidget {
  const TimeLineSelect({
    Key key,
  }) : super(key: key);

  @override
  _TimeLineSelectState createState() => _TimeLineSelectState();
}

class _TimeLineSelectState extends State<TimeLineSelect> {
//  String startTime = DateFormat('HH:mm:ss').format(DateTime.now());
//  String startDate = DateFormat('dd:MM:yyyy').format(DateTime.now());

  String startTime = Jiffy(DateTime.now().toLocal()).format("HH:mm:ss");
  String startDate = Jiffy(DateTime.now()).format("dd:MM:yyyy");

  String endTime;
  String endDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: InkWell(
            onTap: () => showSelectTimeDate(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  FontAwesome5Solid.clock,
                  color: sheetLightColor,
                  size: 35,
                ),
                const SizedBox(
                  width: 6,
                ),
                Text(
                  "Time : " +
                      startTime.toString() +
                      "\n Date:  " +
                      startDate.toString(),
                  style: Theme.of(context).textTheme.display1,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  FontAwesome5Solid.clock,
                  color: sheetLightColor,
                  size: 35,
                ),
                const SizedBox(
                  width: 6,
                ),
                Text(
                  "Time : --:--:-- \n "
                  "Date : --.--.----",
                  style: Theme.of(context).textTheme.display1,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  void showSelectTimeDate(BuildContext context) async {
    {
      TimeOfDay selectedTime;
      DateTime selectedDate;

      selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(Duration(days: 1)),
        lastDate: DateTime(2030),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light(),
            child: child,
          );
        },
      );
      if (selectedDate != null) {
        selectedTime = await showTimePicker(
            context: context, initialTime: TimeOfDay.now());
      }

      if (selectedDate != null && selectedTime != null) {
        savedDateTime = DateTime(selectedDate.year, selectedDate.month,
            selectedDate.day, selectedTime.hour, selectedTime.minute);

        setState(() {
          startDate = Jiffy(savedDateTime).format("dd:MM:yyyy");
          startTime = Jiffy(savedDateTime).format("HH:mm:ss");
        });

        print(startTime + "\n" + startDate);
      }
    }
  }
}
