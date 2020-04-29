import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/state/subjectVM.dart';
import 'package:todo/ui/colors.dart';

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
        color: UIColors.addSubjectSheetLightColor,
        child: StateBuilder(
          models: [subjectVMRM],
          builder: (context, _) {
            File image = subjectVMRM.value.selectedImageFile;
            return image == null
                ? IconButton(
                    onPressed: () => getImage(),
                    icon: Icon(
                      Icons.add_a_photo,
                      color: UIColors.addSubjectSheetYellowColor,
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
    ImageSource source = ImageSource.camera;

    String result = await showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: UIColors.kapaliMavi,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    source = ImageSource.camera;
                    Navigator.pop(context, "camera");
                  },
                  child: Text(
                    "Camera",
                    style: Theme.of(context).textTheme.display3,
                  ),
                ),
                Text("or ", style: Theme.of(context).textTheme.display1),
                FlatButton(
                  onPressed: () {
                    source = ImageSource.gallery;
                    Navigator.pop(context, "gallery");
                  },
                  child: Text("Gallery",
                      style: Theme.of(context).textTheme.display3),
                )
              ],
            ),
          );
        });
    if (result != null) {
      File _image;
      _image = await ImagePicker.pickImage(source: source);
      subjectVMRM.setState((state) => state.selectedImageFile = _image);
      if (_image != null) {
        print(" selected image path : " + _image.path.toString());
      }
    }
  }
}
