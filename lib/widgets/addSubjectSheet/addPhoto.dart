import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/state/addSubjectVM.dart';
import 'package:todo/ui/colors.dart';
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
        color: UIColors.addSubjectSheetLightColor,
        child: StateBuilder<AddSubjectVM>(
          tag: "photo",
          observe: () => RM.get<AddSubjectVM>(),
          builder: (context, addSubjectVMRM) {
            File image = addSubjectVMRM.value.selectedImageFile;
            return image == null
                ? IconButton(
                    onPressed: () async {
                      File _selectedPhoto = await getImage(context);
                      addSubjectVMRM.setState(
                          (s) => s.selectedImageFile = _selectedPhoto,
                          filterTags: ["photo"]);
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
                      addSubjectVMRM.setState(
                          (s) => s.selectedImageFile = _selectedPhoto,
                          filterTags: ["photo"]);
                    },
                    child: Image.file(
                      image,
                      fit: BoxFit.cover,
                    ),
                  );
          },
        ));
  }
}
