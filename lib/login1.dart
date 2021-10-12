import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
// import 'package:followup/signupscreen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Loginscreen extends StatefulWidget {
  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  String idUser = '';
  late TextEditingController hp, password;
  @override
  void initState() {
    hp = new TextEditingController();
    password = new TextEditingController();
    getValidtionData();
    super.initState();
  }

  void userSignIn() async {
    if (hp.text == '') {
      Fluttertoast.showToast(
          msg: "Please complete all fields before submitting.",
          toastLength: Toast.LENGTH_LONG);
      return null;
    }
    if (password.text == '') {
      Fluttertoast.showToast(
          msg: "Please complete all fields before submitting.",
          toastLength: Toast.LENGTH_LONG);
      return null;
    }

    var response = await http
        .post(Uri.https('followup.my', '/process/app/p.login_app.php'), body: {
      "hp": hp.text,
      "password": password.text,
    });

    var resbody = jsonDecode(response.body);

    if (resbody["status"] == 0) {
      Navigator.of(context).pushNamed("home");
      var idUser = resbody['id_user'];
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString("id_user", idUser.toString());
      password.clear();
      hp.clear();
    } else {
      Fluttertoast.showToast(
          msg:
              "Wrong Username/Password. Try again or click forgot password to reset it.",
          toastLength: Toast.LENGTH_LONG);
    }
  }

  Future getValidtionData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var iduser = sharedPreferences.getString('id_user');
    sharedPreferences.setBool('online', false);
    setState(() {
      idUser = iduser.toString();
    });
    // log(iduser.toString());
    if (iduser != null) {
      Navigator.of(context).pushNamed("home");
    }
    // Navigator.of(context).pushNamed("log_in");
    // log(idUser);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('images/back.png'),
          fit: BoxFit.cover,
        )),
        child: Center(
          child: ListView(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 60,
                      width: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("images/logoW.png"),
                        ),
                      ),
                      child: null),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 28),
                    child: Text(
                      "LOGIN",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: height * .2,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 28),
                      child: Text(
                        "PHONE NUMBER",
                        style: TextStyle(color: Colors.white),
                      ))),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 28, vertical: 10),
                child: TextField(
                  controller: hp,
                  keyboardType: TextInputType.number,
                  obscureText: false,
                  decoration: InputDecoration(
                      filled: true,
                      prefixIcon: Icon(Icons.phone_outlined),
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.transparent)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.transparent)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.transparent)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.transparent))),
                  style: TextStyle(
                      color: Colors.black.withOpacity(.6),
                      fontWeight: FontWeight.w600,
                      fontSize: 14),
                ),
              ),
              SizedBox(
                height: height * .02,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 28),
                      child: Text(
                        "PASSWORD",
                        style: TextStyle(color: Colors.white),
                      ))),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 28, vertical: 10),
                child: TextField(
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(
                      filled: true,
                      prefixIcon: Icon(Icons.lock_outlined),
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.transparent)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.transparent)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.transparent)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.transparent))),
                  style: TextStyle(
                      color: Colors.black.withOpacity(.6),
                      fontWeight: FontWeight.w600,
                      fontSize: 14),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 28),
                    child: AnimatedButton(
                        enabled: true,
                        height: 50,
                        width: 160,
                        color: Colors.deepOrange,
                        onPressed: () {
                          userSignIn();
                          // hp.clear();
                          password.clear();
                        },
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        )),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 28),
                    child: Text(
                      'Forgetten Password ?',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: height * .25,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    child: Text(
                      "CREATE A NEW ACCOUNT >",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12),
                    ),
                    onTap: () {
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (ctx) => Signupscreen()));
                    },
                  ),
                  Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        'Powered by',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                        ),
                      )),
                  Container(
                      child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Text(
                      'ExcelFixer',
                      style: TextStyle(
                        color: Colors.blue[200],
                        fontSize: 14.0,
                      ),
                    ),
                  ))
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(context,
                  //         MaterialPageRoute(builder: (ctx) => Signupscreen()));
                  //   },
                  //   child: Text(
                  //     '',
                  //     style: TextStyle(
                  //         color: Color(0xFFFE7550),
                  //         fontWeight: FontWeight.w600,
                  //         fontSize: 18,
                  //         decoration: TextDecoration.underline),
                  //   ),
                  // )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

// class customtextfield extends StatelessWidget {
//   bool issecured;
//   String hint;

//   customtextfield({required this.hint, required this.issecured});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 28, vertical: 10),
//       child: TextField(
//         obscureText: issecured,
//         decoration: InputDecoration(
//             hintText: hint,
//             filled: true,
//             fillColor: Colors.white,
//             focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(16),
//                 borderSide: BorderSide(color: Colors.transparent)),
//             border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(16),
//                 borderSide: BorderSide(color: Colors.transparent)),
//             disabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(16),
//                 borderSide: BorderSide(color: Colors.transparent)),
//             enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(16),
//                 borderSide: BorderSide(color: Colors.transparent))),
//         style: TextStyle(
//             color: Colors.black.withOpacity(.6),
//             fontWeight: FontWeight.w600,
//             fontSize: 14),
//       ),
//     );
//   }
// }
