import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/data/dbHelper.dart';
import 'package:todo/data/models/friend.dart';
import 'package:todo/screens/homeScreen/bottomMenu.dart';
import 'package:todo/screens/homeScreen/daysUI.dart';
import 'package:todo/screens/homeScreen/todosCards.dart';
import 'package:todo/screens/homeScreen/topRow.dart';
import 'package:todo/state/addSubjectVM.dart';
import 'package:todo/state/subjectVM.dart';
import 'package:todo/state/userVM.dart';
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
  final Color blue = UIColors.kapaliMavi;

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
            DaysUI(blue: blue),
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
//      afterInitialBuild: (context) {
////        Test
////        final userVMRM = RM.get<UserVM>();
////        userVMRM.setState((s) {
////          s.user.friends.clear();
////          return s.user.friends.add(
////              Friend(id: "70", userName: "Abra Denk", email: "ayla@mail.co"));
////        });
////        userVMRM.setState((s) => s.user.friends.add(
////            Friend(id: "72", userName: "Sir Jr. Mike", email: "mike@sir.co")));
////      },
      inject: [
        Inject.previous(
            (previous) => AddSubjectVM(IN.get<DatabaseHelper>(),
                friendList: IN.get<UserVM>().user.friends,
                tags: IN.get<SubjectVM>().tags),
            isLazy: false),
      ],
      reinjectOn: [
        // If enabled and user singout its throw null because user == null => user.friends return null
        //RM.get<UserVM>(),
        RM.get<SubjectVM>()
      ],
      builder: (context) => StateBuilder<AddSubjectVM>(
        observe: () => RM.get<AddSubjectVM>(),
        builderWithChild: (x, y, child) => child,
        child: FloatingActionButton(
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
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(50))),
              context: context,
              builder: (builder) {
                return AddSubjectSheet();
              }),
        ),
      ),
    );
  }
}
