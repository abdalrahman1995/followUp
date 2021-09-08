import 'package:flutter/material.dart';
import 'package:followup/add_cust.dart';
// import 'package:followup/info.dart';
import 'Action.dart';
import 'home.dart';
// import 'insert/new_client.dart';
import 'login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LogIn(),
        routes: {
          "log_in": (context) {
            return LogIn();
          },
          "home": (context) {
            return Home();
          },
          "action": (context) {
            return ActionList();
          },
          "add_cust": (context) {
            return AddCust();
          },

          // "new_client": (context) {
          //   return NewClient(
          //     index: 0,
          //     list: {},
          //   );
          // },
        });
  }
}
