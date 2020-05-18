import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo/utility/colors.dart';

Future<File> getImage(BuildContext context) async {
  ImageSource source = ImageSource.camera;
  File _image;
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
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
              Text("or ", style: Theme.of(context).textTheme.headline4),
              FlatButton(
                onPressed: () {
                  source = ImageSource.gallery;
                  Navigator.pop(context, "gallery");
                },
                child: Text("Gallery",
                    style: Theme.of(context).textTheme.headline2),
              )
            ],
          ),
        );
      });
  if (result != null) {
    _image = await ImagePicker.pickImage(source: source);
    if (_image != null) {
      print(" selected image path : " + _image.path.toString());
    }
  }
  return _image;
}
