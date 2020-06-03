import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/screens/homeScreen/bottomMenu.dart';
import 'package:todo/screens/homeScreen/daysUI.dart';
import 'package:todo/screens/homeScreen/todosCards.dart';
import 'package:todo/screens/homeScreen/topRow.dart';
import 'package:todo/state/addSubjectVM.dart';
import 'package:todo/state/subjectVM.dart';
import 'package:todo/utility/colors.dart';
import 'package:todo/widgets/addSubjectSheet/addSubjectSheet.dart';
import 'package:todo/widgets/tagChips.dart';

import 'infoAndFilterRow.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Color grey = UIColors.grey;
  final Color blue = UIColors.darkBlue;

  List<int> chipsSelect = List.generate(10, (index) => index);

  // TODO: fix list lenght using original tag list.lenght

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: grey,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FAB(),
        bottomNavigationBar: BottomMenu(
          blue: blue,
          grey: grey,
        ),
        body: ListView(
          shrinkWrap: true,
          children: <Widget>[
            TopRow(),
            const SizedBox(
              height: 8,
            ),
            DaysUI(),
            const SizedBox(
              height: 8,
            ),
            TagChips(RM.get<SubjectVM>()),
            InfoAndFilterRow(blue: blue),
            ToDosCards(),
          ],
        ),
      ),
    );
  }
}

class FAB extends StatelessWidget {
  const FAB({
    Key key,
  }) : super(key: key);

  final Color sheetBGColor = UIColors.addSubjectSheetBGColor;

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
            builder: (builder) {
              return AddSubjectSheet();
            }),
      ),
    );
  }
}
