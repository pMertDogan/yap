import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:todo/locator.dart';
import 'package:todo/models/subject.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/screens/home/widgets/bottomMenu.dart';
import 'package:todo/screens/home/widgets/daysUI.dart';
import 'package:todo/screens/home/widgets/infoAndFilterRow.dart';
import 'package:todo/screens/home/widgets/tagChips.dart';
import 'package:todo/screens/home/widgets/todosCards.dart';
import 'package:todo/screens/home/widgets/topRow.dart';
import 'package:todo/ui/colors.dart';
import 'package:todo/viewModels/subjectVM.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Color grey = UIColors.grey;
  final Color blue = UIColors.kapaliMavi;
  final Color sheetBGColor = UIColors.addSubjectSheetBGColor;
  final Color sheetLightColor = UIColors.addSubjectSheetLightColor;
  final Color sheetYellowColor = UIColors.addSubjectSheetYellowColor;

  List<int> chipsSelect = List.generate(10, (index) => index);

  // TODO: fix list lenght using original tag list.lenght

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: grey,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () => showModalBottomSheet(
                backgroundColor: sheetBGColor,
                shape: ContinuousRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(50))),
                context: context,
                builder: (builder) {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: Text(
                            "Create a new Subject",
                            style: Theme.of(context)
                                .textTheme
                                .display1
                                .copyWith(fontSize: 26),
                          ),
                        ),
                        TitleText(
                          titleText: "Subject picture",
                        ),
                        Container(
                          height: 132,
                          width: double.infinity,
                          color: sheetLightColor,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.add_a_photo,
                              color: sheetYellowColor,
                              size: 32,
                            ),
                          ),
                        ),
                        SizedBox25(),
                        FractionallySizedBox(
                            widthFactor: 0.8,
                            child: TextFormField(
                              decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: grey)),
                                  border: InputBorder.none,
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: grey))),
                            )),
                        SizedBox25(),
                        TitleText(
                          titleText: "Subject explanation",
                        )
                      ],
                    ),
                  );
                }),
            backgroundColor: Colors.blueGrey),
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

class TitleText extends StatelessWidget {
  const TitleText({Key key, @required this.titleText}) : super(key: key);

  final String titleText;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
        child: Text(
          titleText,
          style: Theme.of(context).textTheme.display3,
        ),
      ),
    );
  }
}

class SizedBox25 extends StatelessWidget {
  const SizedBox25({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
    );
  }
}
