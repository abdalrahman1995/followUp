import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  void initState() {
    super.initState();
  }

  Future logOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences.remove('id_user');
      Navigator.of(context).pushNamed('log_in');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
            color: Colors.white,
            child: ListView(padding: EdgeInsets.zero, children: <Widget>[
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topLeft,
                        colors: [
                      Colors.blue,
                      Colors.white,
                    ])),
                accountEmail: Text(
                  'Abdulrahman',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                accountName: Text(
                  'ExcelFixer',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).platform == TargetPlatform.iOS
                          ? Colors.white
                          : Colors.white,
                  child: Icon(
                    Icons.person,
                    color: Colors.blue,
                    size: 50,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  'Home',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed('home');
                },
              ),
              Divider(
                height: 1,
              ),
              ListTile(
                title: Text(
                  'Profile',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed('home');
                },
              ),
              Divider(
                height: 1,
              ),
              ListTile(
                title: Text(
                  'Logout',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  logOut();
                  // Navigator.pushNamedAndRemoveUntil(
                  //     context, "log_in", (r) => false);
                },
              ),
            ])));
  }

  Container rowbuilder(myimg, mytext) {
    return Container(
      height: 45,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20),
          ),
          Image(
            image: AssetImage(
              myimg,
            ),
            width: 30,
            height: 30,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
          ),
          Text(
            mytext,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
