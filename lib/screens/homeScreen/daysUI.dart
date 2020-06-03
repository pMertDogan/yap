import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/state/subjectVM.dart';
import 'package:todo/utility/colors.dart';

class DaysUI extends StatelessWidget {
  const DaysUI({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: StateBuilder<SubjectVM>(
        observe: () => RM.get<SubjectVM>(),
        builder: (context, subjectVMRM) => ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: subjectVMRM.state.listOfSubjectsStartDates.length + 1,
          itemExtent: 125,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () => subjectVMRM.setState((s) async {
                if (s.selectedStartDayIndex != index) {
                  s.selectedStartDayIndex = index;
                  if (index == 0) {
                    return await s.getInitDatas();
                  } else {
                    return await s.getSelectedDayData();
                  }
                }
              }),
              child: Container(
                decoration: BoxDecoration(
                    color: index == subjectVMRM.state.selectedStartDayIndex
                        ? UIColors.lightBlue
                        : UIColors.darkBlue,
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
                        index == 0
                            ? "All"
                            : Jiffy(
                                    subjectVMRM.state
                                        .listOfSubjectsStartDates[index - 1],
                                    "yyyy-MM-dd")
                                .format("EEEE"),
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(fontSize: 21),
                      ),
                    ),
                    Container(
                      color: UIColors.todoOrange,
                      child: Padding(
                        padding: const EdgeInsets.all(3),
                        child: Text(
                          ((index == 0
                                  ? subjectVMRM.state.listOfAllSubjects.length
                                      .toString()
                                  : subjectVMRM
                                      .state
                                      .listOfTotalSubjectCountForEachDay[
                                          index - 1]
                                      .toString()) +
                              " todo's"),
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
