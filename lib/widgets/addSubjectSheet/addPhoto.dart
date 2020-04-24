import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/state/subjectVM.dart';
import 'package:todo/widgets/addSubjectSheet/addSubjectSheet.dart';

class AddPhoto extends StatefulWidget {
  const AddPhoto({
    Key key,
  }) : super(key: key);

  @override
  _AddPhotoState createState() => _AddPhotoState();
}

class _AddPhotoState extends State<AddPhoto> {
  final ReactiveModel<SubjectVM> subjectVMRM =
      Injector.getAsReactive<SubjectVM>();

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 132,
        width: double.infinity,
        color: sheetLightColor,
        child: StateBuilder(
          models: [subjectVMRM],
          builder: (context, _) {
            File image = subjectVMRM.value.selectedImageFile;
            return image == null
                ? IconButton(
                    onPressed: () => getImage(),
                    icon: Icon(
                      Icons.add_a_photo,
                      color: sheetYellowColor,
                      size: 32,
                    ),
                  )
                : InkWell(
                    onTap: () => getImage(),
                    child: Image.file(
                      image,
                      fit: BoxFit.cover,
                    ),
                  );
          },
        ));
  }

  Future getImage() async {
    File _image;
    _image = await ImagePicker.pickImage(source: ImageSource.gallery);
    subjectVMRM.setState((state) => state.selectedImageFile = _image);
    if (_image != null) {
      print(" selected image path : " + _image.path.toString());
    }
  }
}
