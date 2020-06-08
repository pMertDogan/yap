import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/state/addSubjectVM.dart';
import 'package:todo/utility/colors.dart';
import 'package:todo/widgets/pickImage.dart';

class AddPhoto extends StatefulWidget {
  const AddPhoto({
    Key key,
  }) : super(key: key);

  @override
  _AddPhotoState createState() => _AddPhotoState();
}

class _AddPhotoState extends State<AddPhoto> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 132,
        width: double.infinity,
        color: UIColors.purple,
        child: StateBuilder<AddSubjectVM>(
          tag: "photo",
          //watch: (s) => s.state.subject.picLocal,
          observe: () => RM.get<AddSubjectVM>(),
          builder: (context, addSubjectVMRM) {
            String image = addSubjectVMRM.state.subject.picLocal;
            return image == null
                ? IconButton(
                    onPressed: () async {
                      File _selectedPhoto = await getImage(context);
                      if (_selectedPhoto != null) {
                        addSubjectVMRM.setState((s) {
                          s.subject.picLocal = _selectedPhoto.path;
                        }, filterTags: ["photo"]);
                      }
                    },
                    icon: Icon(
                      Icons.add_a_photo,
                      color: UIColors.addSubjectSheetYellowColor,
                      size: 32,
                    ),
                  )
                : InkWell(
                    onTap: () async {
                      File _selectedPhoto = await getImage(context);
                      addSubjectVMRM.setState((s) {
                        s.subject.picLocal =
                            _selectedPhoto != null ? _selectedPhoto.path : null;
                      }, filterTags: ["photo"]);
                    },
                    child: Image.file(
                      File(image),
                      fit: BoxFit.cover,
                    )
//                    child: Image.asset(
//                      image,
//                      fit: BoxFit.cover,
//                    ),
                    );
          },
        ));
  }
}
