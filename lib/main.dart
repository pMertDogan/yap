import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:todo/data/dbHelper.dart';
import 'package:todo/data/services/fakeAuthService.dart';
import 'package:todo/screens/homeScreen/homeScreen.dart';
import 'package:todo/screens/loginScreen/loginScreen.dart';
import 'package:todo/state/subjectVM.dart';
import 'package:todo/state/userVM.dart';
import 'package:todo/widgets/themeData.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Yap',
      theme: buildThemeData(),
      home: Injector(
        inject: [
          Inject<DatabaseHelper>(() => DatabaseHelper()),
          Inject<UserVM>(
              () => UserVM(FakeAuthService(), IN.get<DatabaseHelper>())),
          Inject<SubjectVM>(() => SubjectVM(IN.get<DatabaseHelper>())),
        ],
        builder: (context) => MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WhenRebuilder(
      observe: () => RM.future(IN.get<UserVM>().getCurrentUser()),
      onIdle: () => IdleScreen(),
      onWaiting: () => LoadingScreen(),
      onError: (error) => Text(error.toString()),
      onData: (_) {
        return StateBuilder(
          //Observe UserVM
          observe: () => RM.get<UserVM>(),
          //Watch user status
          watch: (userVMRM) => userVMRM.state.user,
          //If User != null redirect to homepage
          builder: (_, userVMRM) {
            return userVMRM.state.user != null ? HomeScreen() : LoginScreen();
          },
          afterRebuild: (context, userVMRM) {
            if (userVMRM.state.user != null) {
              RM
                  .get<SubjectVM>()
                  .setState((s) => s.getAllSubjects(), silent: true);
            }
          },
        );
      },
    );
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: CircularProgressIndicator(backgroundColor: Colors.grey)));
  }
}

class IdleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "Yap",
      style: TextStyle(fontSize: 71, color: Color.fromRGBO(53, 73, 94, 1)),
    );
  }
}
