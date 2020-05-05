import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/state/subjectVM.dart';
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
        child: StateBuilder<SubjectVM>(
          observe: () => RM.get<SubjectVM>(),
          builder: (context, subjectVMRM) {
            File image = subjectVMRM.value.selectedImageFile;
            return image == null
                ? IconButton(
                    onPressed: () async {
                      File _selectedPhoto = await getImage(context);
                      subjectVMRM.value.selectedImageFile = _selectedPhoto;
                    },
                    icon: Icon(
                      Icons.add_a_photo,
                      color: UIColors.addSubjectSheetYellowColor,
                      size: 32,
                    ),
                  )
                : InkWell(
                    onTap: () => getImage(context),
                    child: Image.file(
                      image,
                      fit: BoxFit.cover,
                    ),
                  );
          },
        ));
  }
}
