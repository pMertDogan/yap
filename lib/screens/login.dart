import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final List<String> message = [
    "Yap is simple powerfull todo app",
    "Its support colloboration with your friends",
    "You can chat with your friends about todos"
  ];
  final Color kapaliMavi = Color.fromRGBO(53, 73, 94, 1);
  final Color grey = Color.fromRGBO(216, 216, 216, 1);
  double width;
  double height;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        bottomNavigationBar: Container(
          color: kapaliMavi,
          child: TabBar(
            indicatorColor: grey,
            tabs: [
              Tab(
                  child: Text(
                "Login",
                style: Theme.of(context).textTheme.display1,
              )),
              Tab(
                  child: Text(
                "Sing Up",
                style: Theme.of(context).textTheme.display1,
              )),
            ],
          ),
        ),
        body: SafeArea(
          child: Container(
            //height: height,
            //width: width,
            color: grey,
            child: Column(
              children: <Widget>[
                Container(
                  color: grey,
                  height: 300,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(50.0),
                        child: Text(
                          "Yap",
                          style: TextStyle(
                              fontSize: 71,
                              color: Color.fromRGBO(53, 73, 94, 1)),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 25),
                          child: Swiper(
                            itemBuilder: (BuildContext context, int index) {
                              return Text(
                                message[index],
                                style:
                                    TextStyle(fontSize: 23, color: kapaliMavi),
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
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        //   color: Colors.orange,
                        ),
                    child: TabBarView(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: kapaliMavi,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  "Welcome",
                                  style: Theme.of(context)
                                      .textTheme
                                      .display1
                                      .copyWith(fontSize: 25),
                                ),
                              ),
                              FractionallySizedBox(
                                widthFactor: 0.8,
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: TextFormField(
                                        style: Theme.of(context)
                                            .textTheme
                                            .display1,
                                        decoration: InputDecoration(
                                          labelText: "Email",
                                          prefixIcon: Icon(
                                            Icons.email,
                                            color: grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: TextFormField(
                                        obscureText: true,
                                        style: Theme.of(context)
                                            .textTheme
                                            .display1,
                                        decoration: InputDecoration(
                                          labelText: "Password",
                                          prefixIcon: Icon(
                                            Icons.lock_outline,
                                            color: grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: FlatButton(
                                        child: Text(
                                          "lost password?",
                                          style: Theme.of(context)
                                              .textTheme
                                              .display1,
                                        ),
                                        onPressed: () {},
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Stack(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 50,
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: kapaliMavi,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20))),
                                    child: Column(
                                      children: <Widget>[
                                        SizedBox(
                                          height: 60,
                                          width: double.infinity,
                                        ),
                                        FractionallySizedBox(
                                          widthFactor: 0.8,
                                          child: Column(
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5),
                                                child: TextFormField(
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .display1,
                                                  decoration: InputDecoration(
                                                    labelText: "Username",
                                                    prefixIcon: Icon(
                                                      Icons.perm_identity,
                                                      color: grey,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5),
                                                child: TextFormField(
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .display1,
                                                  decoration: InputDecoration(
                                                    labelText: "Email",
                                                    prefixIcon: Icon(
                                                      Icons.email,
                                                      color: grey,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5),
                                                child: TextFormField(
                                                  obscureText: true,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .display1,
                                                  decoration: InputDecoration(
                                                    labelText: "Password",
                                                    prefixIcon: Icon(
                                                      Icons.lock_outline,
                                                      color: grey,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              //Spacer(),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Positioned(
                                left: (width / 2) - 50,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.add_a_photo,
                                    color: kapaliMavi,
                                  ),
                                  radius: 50,
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}