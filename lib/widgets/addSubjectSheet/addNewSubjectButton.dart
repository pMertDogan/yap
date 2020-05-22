import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/state/addSubjectVM.dart';
import 'package:todo/state/subjectVM.dart';
import 'package:todo/utility/colors.dart';
import 'package:todo/widgets/orangeLoadingIndicator.dart';

class AddNewSubjectButton extends StatelessWidget {
  const AddNewSubjectButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          RM.get<SubjectVM>().setState((s) async {
            final a = RM.get<AddSubjectVM>();
            a.state.addTagsToSubject();
            await s.addSubject(a.state.subject);
            //remove tags for new subjects
            a.state.clearFields();
          }, onData: (_, __) => Navigator.pop(context));
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 100),
          decoration: BoxDecoration(
              color: UIColors.todoOrange,
              borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
            child: StateBuilder<SubjectVM>(
              observe: () => RM.get<SubjectVM>(),
              builderWithChild: (context, subjectVMRM, child) {
                return subjectVMRM.isWaiting ? OrangeLoadingIndicator() : child;
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "All is well",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                  Icon(
                    Icons.check,
                    color: Colors.green,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
