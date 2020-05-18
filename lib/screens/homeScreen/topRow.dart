import 'dart:io';

import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/state/userVM.dart';
import 'package:todo/utility/colors.dart';
import 'package:todo/widgets/orangeLoadingIndicator.dart';
import 'package:todo/widgets/pickImage.dart';

class TopRow extends StatelessWidget {
  const TopRow({
    Key key,
  }) : super(key: key);

  final Color blue = UIColors.kapaliMavi;
  final Color grey = UIColors.grey;

  @override
  Widget build(BuildContext context) {
    final userVMRM = RM.get<UserVM>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        RoundedAvatar(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              "Welcome , " + userVMRM.state.user.name.toString(),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style:
                  Theme.of(context).textTheme.headline3.copyWith(fontSize: 25),
            ),
          ),
        ),
        InkWell(
          onTap: () => userVMRM.setState((s) => s.singOut()),
          child: Icon(
            Icons.settings,
            color: blue,
          ),
        )
      ],
    );
  }
}

class RoundedAvatar extends StatelessWidget {
  const RoundedAvatar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StateBuilder<UserVM>(
      tag: "avatarHome",
      observe: () => RM.get<UserVM>(),
      builder: (context, userVMRM) {
        //TODO what about photoLocal?
        String photoURL =
            userVMRM.state.user != null ? userVMRM.state.user.photoURL : null;
        return InkWell(
          onTap: () async {
            File _selectedImage = await getImage(context);
            if (_selectedImage != null) {
              userVMRM.setState((s) => s.changeUserPhoto(_selectedImage),
                  filterTags: ["avatarHome"]);
            }
          },
          child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                  color: UIColors.kapaliMavi,
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(8))),
              child: userVMRM.isWaiting
                  ? OrangeLoadingIndicator()
                  : photoURL == null
                      ? Icon(
                          Icons.add_a_photo,
                          size: 50,
                          color: UIColors.grey,
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(8)),
                          child: Image.network(
                            photoURL,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes
                                      : null,
                                ),
                              );
                            },
                          ),
                        )),
        );
      },
    );
  }
}
