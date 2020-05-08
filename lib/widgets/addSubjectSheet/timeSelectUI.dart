import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:jiffy/jiffy.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/state/addSubjectVM.dart';
import 'package:todo/ui/colors.dart';
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
  //RM.key can be used , but its work :). Rule 1 : If its work dont touch
  final ReactiveModel<AddSubjectVM> addSubjectVMRM = RM.get<AddSubjectVM>();

//  @override
//  void initState() {
//    addSubjectVMRM.value.startDate = Jiffy(DateTime.now()).format("dd/MM/yyyy");
//    addSubjectVMRM.value.startTime =
//        Jiffy(DateTime.now().toLocal()).format("HH:mm:ss");
//    super.initState();
//  }

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
                  color: UIColors.addSubjectSheetLightColor,
                  size: 35,
                ),
                const SizedBox(
                  width: 6,
                ),
                StateBuilder<AddSubjectVM>(
                  tag: "startTimeDate", //check initState error ?
                  initState: (context, addSubjectVMRM) {
                    //Check for error if error move this codes to initState of the StateFullWidget
                    addSubjectVMRM.value.startDate =
                        Jiffy(DateTime.now()).format("dd/MM/yyyy");
                    addSubjectVMRM.value.startTime =
                        Jiffy(DateTime.now().toLocal()).format("HH:mm:ss");
                  },
                  observe: () => addSubjectVMRM,
                  builder: (context, _) => Text(
                    "Time : " +
                        addSubjectVMRM.value.startTime.toString() +
                        "\n Date:  " +
                        addSubjectVMRM.value.startDate.toString(),
                    style: Theme.of(context).textTheme.display1,
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
                  color: UIColors.addSubjectSheetLightColor,
                  size: 35,
                ),
                const SizedBox(
                  width: 6,
                ),
                StateBuilder<AddSubjectVM>(
                  tag: "endTimeDate",
                  observe: () => addSubjectVMRM,
                  builder: (context, addSubjectVMRM) => Text(
                    addSubjectVMRM.value.endDate == null
                        ? "-- : -- :--\n"
                            "-- / -- /--"
                        : "Time : " +
                            addSubjectVMRM.value.endTime.toString() +
                            "\n Date:  " +
                            addSubjectVMRM.value.endDate.toString(),
                    style: Theme.of(context).textTheme.display1,
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
    {
      TimeOfDay selectedTime;
      DateTime selectedDate;
      selectedDate = await showDatePicker(
        context: context,
        initialDate: !selectForEnd
            ? DateTime.now()
            : addSubjectVMRM.value.endDateInitDate.add(Duration(days: 4)),
        firstDate: !selectForEnd
            ? DateTime.now().subtract(Duration(days: 1))
            : addSubjectVMRM.value.endDateInitDate,
        //lastDate: DateTime.now(),
        lastDate: !selectForEnd
            ? addSubjectVMRM.value.startDateLastDate ?? DateTime(2030)
            : DateTime(2030),
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

        addSubjectVMRM.setState((state) {
          if (!selectForEnd) {
            state.startDate = Jiffy(savedDateTime).format("dd/MM/yyyy");
            return state.startTime = Jiffy(savedDateTime).format("HH:mm:ss");
          } else {
            state.endDate = Jiffy(savedDateTime).format("dd/MM/yyyy");
            return state.endTime = Jiffy(savedDateTime).format("HH:mm:ss");
          }
        }, filterTags: ["startTimeDate", "endTimeDate"]);
      }
    }
  }
}
