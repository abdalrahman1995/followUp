import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool signin = true;
  String idUser = '';

  late TextEditingController hp, name, password, confirmpass;
  GlobalKey<FormState> formstatesignin = new GlobalKey<FormState>();
  GlobalKey<FormState> formstatesignup = new GlobalKey<FormState>();

  bool processing = false;

  @override
  void initState() {
    hp = new TextEditingController();
    name = new TextEditingController();
    password = new TextEditingController();
    confirmpass = new TextEditingController();
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
    setState(() {
      processing = true;
    });
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

    setState(() {
      processing = false;
    });
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
    // if (iduser.toString() != null) {
    //   Navigator.of(context).pushNamed("home");
    // }
    // Navigator.of(context).pushNamed("log_in");
    // log(idUser);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
            Colors.blue,
            Colors.white,
          ])),
      child: boxUi(),
    );
  }

  void changeState() {
    if (signin) {
      setState(() {
        signin = false;
      });
    } else
      setState(() {
        signin = true;
      });
  }

  Widget boxUi() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: 300,
        height: 550,
        child: Card(
          elevation: 10.0,
          color: Colors.white10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 65),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[],
                ),
                signin == true ? signInUi() : signUpUi(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget signInUi() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 600),
      curve: Curves.easeInBack,
      child: SingleChildScrollView(
        child: Form(
          key: formstatesignin,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              Text(
                'Follow Up',
                style: GoogleFonts.varelaRound(
                  color: Colors.white,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // buildTextFieldAll(false, company, "Company Code"),
              buildTextFieldAll(false, hp, 'Contact', TextInputType.number),
              buildTextFieldAll(true, password, 'Password', TextInputType.text),
              MaterialButton(
                  onPressed: () {
                    // restPassword(context);
                  },
                  child: Text(
                    'Forgot your password ?',
                    style: GoogleFonts.varelaRound(
                        fontSize: 10.0, color: Colors.red),
                  )),
              MaterialButton(
                  onPressed: () async {
                    userSignIn();
                    // Navigator.of(context).pushNamed("home");
                  },
                  child: processing == false
                      ? Text(
                          'Login',
                          style: GoogleFonts.varelaRound(
                              fontSize: 18.0, color: Colors.black),
                        )
                      : CircularProgressIndicator(
                          backgroundColor: Colors.white,
                          value: 2,
                        )),
              MaterialButton(
                  onPressed: () {
                    changeState();
                    hp.clear();
                    password.clear();
                  },
                  child: Text(
                    'Register your interest',
                    style: GoogleFonts.varelaRound(
                      fontSize: 12.0,
                      color: Colors.white,
                    ),
                  )),
              Container(
                  margin: EdgeInsets.only(top: 58),
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
                  color: Colors.white24,
                ),
                child: Text(
                  'ExcelFixer',
                  style: TextStyle(
                    color: Colors.blue[400],
                    fontSize: 14.0,
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  Widget signUpUi() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 600),
      curve: Curves.easeInBack,
      height: 420,
      child: SingleChildScrollView(
        child: Form(
          key: formstatesignup,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              Text(
                'Follow Up',
                style: GoogleFonts.varelaRound(
                  color: Colors.white,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              buildTextFieldAll(false, name, 'Name', TextInputType.text),
              TextField(
                obscureText: false,
                style: TextStyle(color: Colors.black),
                controller: hp,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: "Contact",
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    )),
              ),
              // buildTextFieldAll(false, email, 'Email'),
              buildTextFieldAll(true, password, 'Password', TextInputType.text),
              buildTextFieldAll(
                  true, confirmpass, 'Confirm Password', TextInputType.text),
              SizedBox(
                height: 10.0,
              ),
              MaterialButton(
                  onPressed: () {
                    // registerUser();
                    // popUpInfo(context);
                  },
                  child: processing == false
                      ? Text(
                          'Sign Up',
                          style: GoogleFonts.varelaRound(
                              fontSize: 18.0, color: Colors.black),
                        )
                      : CircularProgressIndicator(
                          backgroundColor: Colors.white,
                          value: 1,
                        )),
              MaterialButton(
                  onPressed: () {
                    changeState();
                    hp.clear();
                    password.clear();
                    name.clear();
                    confirmpass.clear();
                  },
                  child: Text(
                    ' Back ',
                    style: GoogleFonts.varelaRound(
                      fontSize: 12.0,
                      color: Colors.blueAccent,
                    ),
                  )),
              Container(
                  child: Text(
                'Powered by',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
              )),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: Colors.white24,
                  ),
                  child: Text(
                    'ExcelFixer',
                    style: TextStyle(
                      color: Colors.blue[400],
                      fontSize: 14.0,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  TextField buildTextFieldAll(bool pass, TextEditingController mycompanyctrl,
      String myhintText, roomKeyboardType) {
    return TextField(
      obscureText: pass,
      style: TextStyle(color: Colors.white),
      controller: mycompanyctrl,
      keyboardType: roomKeyboardType,
      decoration: InputDecoration(
          hintText: myhintText,
          hintStyle: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          )),
    );
  }
}
