import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/data/models/subject.dart';
import 'package:todo/state/detailVM.dart';
import 'package:todo/utility/colors.dart';

import 'orangeLoadingIndicator.dart';

void showAddTagSheet(Subject subject) {
  Set<String> setOfTags = <String>{}..addAll(subject.tags);

  showBottomSheet(
      backgroundColor: UIColors.darkBlue,
      context: RM.context,
      //isScrollControlled: true,
      builder: (BuildContext context) {
        String inputText;
        return StateBuilder<List<int>>(
          observe: () => RM.create<List<int>>(
              List.generate(setOfTags.length, (index) => index)),
          builder: (context, model) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Add new or remove tag"),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      autovalidate: true,
                      validator: (txt) {
                        if (txt.length < 1) {
                          return "Please  type new tag name";
                        } else if (setOfTags.contains(txt)) {
                          return "Tag already exists";
                        } else {
                          inputText = txt;
                          return null;
                        }
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange)),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange)),
                        errorStyle:
                            TextStyle(color: Colors.orange, fontSize: 16),
                        hintText: "Please input new tag name",
                        suffixIcon: InkWell(
                          onTap: () => model.setState((s) {
                            setOfTags.add(inputText);
                            s.add(setOfTags.length - 1);
                          }),
                          child: Icon(
                            FlutterIcons.add_circle_outline_mdi,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: setOfTags.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 40,
                              //width: 4,
                              child: FilterChip(
                                  onSelected: (selected) {
                                    if (selected) {
                                      model.setState((s) => s.add(index));
                                    } else {
                                      model.setState((s) => s.removeWhere(
                                          (itemIndex) => itemIndex == index));
                                    }
                                  },
                                  backgroundColor: Colors.grey,
                                  selectedColor: Colors.blueGrey,
                                  label: Text(
                                    setOfTags.elementAt(index),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  selected: model.state.contains(index)),
                            ),
                          )),
                ),
                StateBuilder<DetailVM>(
                  observe: () => RM.get<DetailVM>(),
                  builderWithChild: (context, model, child) =>
                      model.isWaiting ? OrangeLoadingIndicator() : child,
                  child: MaterialButton(
                    onPressed: () async {
                      //get selected tags
                      Set<String> selectedTagNames = <String>{};
                      await Future.forEach(model.state, (tagIndex) {
                        selectedTagNames.add(setOfTags.elementAt(tagIndex));
                      });
                      //send selected tags  to save
                      await RM.get<DetailVM>().setState(
                          (s) => s.updateSubjectTags(selectedTagNames));
                      RM.navigator.pop();
                    },
                    color: Colors.orange,
                    child: Text(
                      "Save",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                )
              ],
            );
          },
        );
      });
}
