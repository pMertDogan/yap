import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:jiffy/jiffy.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/state/addSubjectVM.dart';
import 'package:todo/utility/colors.dart';
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
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: InkWell(
            onTap: () => showSelectTimeDate(context, selectForEnd: false),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  FontAwesome5Solid.clock,
                  color: UIColors.purple,
                  size: 35,
                ),
                const SizedBox(
                  width: 6,
                ),
                StateBuilder<AddSubjectVM>(
                  tag: "startTimeDate", //check initState error ?
                  initState: (context, addSubjectVMRM) {
                    //Check for error if error move this codes to initState of the StateFullWidget
                    addSubjectVMRM.state.subject.startDate =
                        Jiffy(DateTime.now()).format("dd/MM/yyyy");
                    addSubjectVMRM.state.subject.startTime =
                        Jiffy(DateTime.now().toLocal()).format("HH:mm:ss");
                  },
                  observe: () => RM.get<AddSubjectVM>(),
                  builder: (context, addSubjectVMRM) => Text(
                    "Time : " +
                        addSubjectVMRM.state.subject.startTime.toString() +
                        "\n Date:  " +
                        addSubjectVMRM.state.subject.startDate.toString(),
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () => showSelectTimeDate(context, selectForEnd: true),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  FontAwesome5Solid.clock,
                  color: UIColors.purple,
                  size: 35,
                ),
                const SizedBox(
                  width: 6,
                ),
                StateBuilder<AddSubjectVM>(
                  initState: (context, addRM) => addRM.state.endDateInitDate =
                      DateTime.now(), // for fix null error
                  tag: "endTimeDate",
                  observe: () => RM.get<AddSubjectVM>(),
                  builder: (context, addSubjectVMRM) => Text(
                    addSubjectVMRM.state.subject.endDate == null
                        ? "-- : -- :--\n"
                            "-- / -- /--"
                        : "Time : " +
                            addSubjectVMRM.state.subject.endTime.toString() +
                            "\n Date:  " +
                            addSubjectVMRM.state.subject.endDate.toString(),
                    style: Theme.of(context).textTheme.headline4,
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  void showSelectTimeDate(BuildContext context,
      {@required bool selectForEnd}) async {
    final ReactiveModel<AddSubjectVM> addSubjectVMRM = RM.get<AddSubjectVM>();

    TimeOfDay selectedTime;
    DateTime selectedDate;
    selectedDate = await showDatePicker(
      context: context,
      initialDate: selectForEnd
          ? addSubjectVMRM.state.endDateInitDate.add(Duration(days: 4))
          : DateTime.now(),
      firstDate: selectForEnd
          ? addSubjectVMRM.state.endDateInitDate
          : DateTime.now(), //DateTime.now().subtract(Duration(days: 1)),
      lastDate: selectForEnd
          ? DateTime(2030)
          : addSubjectVMRM.state.startDateLastDate ?? DateTime(2030),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );
    if (selectedDate != null) {
      selectedTime =
          await showTimePicker(context: context, initialTime: TimeOfDay.now());
    }
    //if user selected date and time
    if (selectedDate != null && selectedTime != null) {
      savedDateTime = DateTime(selectedDate.year, selectedDate.month,
          selectedDate.day, selectedTime.hour, selectedTime.minute);

      addSubjectVMRM.setState((state) {
        if (!selectForEnd) {
          state.startDate = Jiffy(savedDateTime).format("dd/MM/yyyy");
          return state.subject.startTime =
              Jiffy(savedDateTime).format("HH:mm:ss");
        } else {
          state.endDate = Jiffy(savedDateTime).format("dd/MM/yyyy");
          return state.subject.endTime =
              Jiffy(savedDateTime).format("HH:mm:ss");
        }
      }, filterTags: ["startTimeDate", "endTimeDate"]);
    }
  }
}
