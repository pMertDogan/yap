import 'dart:io';

import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/models/user.dart';
import 'package:todo/state/userVM.dart';
import 'package:todo/ui/colors.dart';
import 'package:todo/widgets/orangeLoadingIndicator.dart';
import 'package:todo/widgets/pickImage.dart';

class TopRow extends StatelessWidget {
  const TopRow({
    Key key,
    @required this.blue,
    @required this.grey,
  }) : super(key: key);

  final Color blue;
  final Color grey;

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
              "Welcome , " + userVMRM.state.user.userName.toString(),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style:
                  Theme.of(context).textTheme.display2.copyWith(fontSize: 25),
            ),
          ),
        ),
        Icon(
          Icons.settings,
          color: blue,
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
      observe: () => RM.get<UserVM>(),
      //watch: (userVMRM) => userVMRM.state.user,
      builder: (context, ReactiveModel<UserVM> userVMRM) {
        String photoURL = userVMRM.state.user.photoURL;

        return InkWell(
          onTap: () async {
            File _selectedImage = await getImage(context);
            if (_selectedImage != null) {
              userVMRM.setState(
                  (s) async => await s.changeUserPhoto(_selectedImage));
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
