import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:todo/ui/colors.dart';
import 'package:todo/widgets/addSubjectSheet/addSubjectSheet.dart';
import 'package:todo/widgets/homeScreen/bottomMenu.dart';
import 'package:todo/widgets/homeScreen/daysUI.dart';
import 'package:todo/widgets/homeScreen/infoAndFilterRow.dart';
import 'package:todo/widgets/homeScreen/tagChips.dart';
import 'package:todo/widgets/homeScreen/todosCards.dart';
import 'package:todo/widgets/homeScreen/topRow.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
            TopRow(blue: blue, grey: grey),
            const SizedBox(
              height: 8,
            ),
            DaysUI(blue: blue),
            const SizedBox(
              height: 8,
            ),
            TagChips(chipsSelect: chipsSelect, grey: grey),
            InfoAndFilterRow(blue: blue),
            TodosCards(),
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
    return FloatingActionButton(
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
    );
  }
}
