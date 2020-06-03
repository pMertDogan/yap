import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:todo/utility/colors.dart';
import 'package:todo/utility/strings.dart';

class TopInfoArea extends StatelessWidget {
  const TopInfoArea({
    Key key,
  }) : super(key: key);

  final Color kapaliMavi = UIColors.darkBlue;
  final Color grey = UIColors.grey;
  final List<String> message = UIStrings.loginUIMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: grey,
      height: 250,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Text(
              "Yap",
              style:
                  TextStyle(fontSize: 71, color: Color.fromRGBO(53, 73, 94, 1)),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return Text(
                    message[index],
                    style: TextStyle(fontSize: 23, color: kapaliMavi),
                  );
                },
                autoplay: true,
                itemCount: message.length,
                viewportFraction: 0.8,
                scale: 0.9,
                pagination: new SwiperPagination(
                  builder: new DotSwiperPaginationBuilder(
                      activeColor: Colors.deepOrange),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
