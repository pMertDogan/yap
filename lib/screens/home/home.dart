import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_icons/flutter_icons.dart';
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
                //enable scroll down to close
                isScrollControlled: true,
                backgroundColor: sheetBGColor,
                shape: ContinuousRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(50))),
                context: context,
                builder: (builder) {
                  return Container(
                    //set bottom sheet heiht to %90
                    height: MediaQuery.of(context).size.height * 0.9,
                    child: SingleChildScrollView(
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        runSpacing: 10,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
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
                          TitleText(
                            titleText: "Subject title",
                          ),
                          FractionallySizedBox(
                              widthFactor: 0.8,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: sheetLightColor,
                                    borderRadius: BorderRadius.circular(8)),
                                //margin: EdgeInsets.all(5),
                                padding: EdgeInsets.all(5),
                                child: TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                      hintText: "What should do?",
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: grey)),
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none),
                                ),
                              )),

                          TitleText(
                            titleText: "  Subject explanation",
                          ),
                          Container(
                            color: sheetLightColor,
                            padding: EdgeInsets.all(5),
                            child: TextFormField(
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  hintText: "  Everyone likes little secrets",
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: grey)),
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none),
                            ),
                          ),
                          Text(
                            "Timeline",
                            style: TextStyle(color: Colors.amber, fontSize: 18),
                          ),
                          Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: InkWell(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                            "Time : 01:08:00 \n "
                                            "Date : 14.04.2020",
                                            style: Theme.of(context)
                                                .textTheme
                                                .display1,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                            style: Theme.of(context)
                                                .textTheme
                                                .display1,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          //Keyboard height as padding for let user see fields
                          Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                          )
                        ],
                      ),
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
  const TitleText({Key key, @required this.titleText, this.padding = true})
      : super(key: key);

  final String titleText;
  final bool padding;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: padding
            ? EdgeInsets.only(left: 20, top: 10, bottom: 10)
            : EdgeInsets.only(),
        child: Text(
          titleText,
          style: Theme.of(context).textTheme.display3,
        ),
      ),
    );
  }
}
