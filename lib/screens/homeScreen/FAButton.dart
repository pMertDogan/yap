import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/state/addSubjectVM.dart';
import 'package:todo/utility/colors.dart';
import 'package:todo/widgets/addSubjectSheet/addSubjectSheet.dart';

class FAB extends StatelessWidget {
  const FAB({
    Key key,
  }) : super(key: key);

  final Color sheetBGColor = UIColors.darkerPurple;

  @override
  Widget build(BuildContext context) {
    return Injector(
      inject: [
        Inject<AddSubjectVM>(() => AddSubjectVM()),
      ],
      builder: (context) => FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.blueGrey,
        onPressed: () => showModalBottomSheet(
            //enable scroll down to close
            isScrollControlled: true,
            backgroundColor: sheetBGColor,
            shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(50))),
            context: context,
            builder: (context) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
                child: Scaffold(
                  body: AddSubjectSheet(),
                  backgroundColor: Colors.transparent,
                ),
              );
            }),
      ),
    );
  }
}
