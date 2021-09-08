import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../navigationbar.dart';
import 'dart:developer';

String idUser = '';

class NewClient extends StatefulWidget {
  final Map<String, dynamic> list;
  final int index;
  NewClient({required this.index, required this.list});
  @override
  _NewClientState createState() => _NewClientState();
}

class _NewClientState extends State<NewClient> {
  late TextEditingController company, name, hp, email, category;
  String buttonText = '';

  @override
  void initState() {
    getValidtionData();
    // buttonText = "Create";
    idUser = '1';
    company = new TextEditingController();
    name = new TextEditingController();
    hp = new TextEditingController();
    email = new TextEditingController();
    category = new TextEditingController();
    // ignore: unnecessary_null_comparison
    if (widget.index != null) {
      company.text = widget.list['comp'];
      name.text = widget.list['name'];
      hp.text = widget.list['hp'];
      email.text = widget.list['email'];
      category.text = widget.list['category'];
      buttonText = 'Update';
    }

    super.initState();
  }

  Future getValidtionData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var iduser = sharedPreferences.getString('id_user');
    sharedPreferences.setBool('online', false);
    setState(() {
      idUser = iduser.toString();
    });
  }

  void updateche(id, String button) async {
    if (company.text == '') {
      Fluttertoast.showToast(
          msg: "Please ensure all required fields are completed.",
          toastLength: Toast.LENGTH_LONG);
      return null;
    }

    if (name.text == '') {
      Fluttertoast.showToast(
          msg: "Please ensure all required fields are completed.",
          toastLength: Toast.LENGTH_LONG);
      return null;
    }
    if (hp.text == '') {
      Fluttertoast.showToast(
          msg: "Please ensure all required fields are completed.",
          toastLength: Toast.LENGTH_LONG);
      return null;
    }
    if (email.text == '') {
      Fluttertoast.showToast(
          msg: "Please ensure all required fields are completed.",
          toastLength: Toast.LENGTH_LONG);
      return null;
    }
    if (category.text == '') {
      Fluttertoast.showToast(
          msg: "Please ensure all required fields are completed.",
          toastLength: Toast.LENGTH_LONG);
      return null;
    }
    var response = await http
        .post(Uri.https('followup.my', '/process/app/p.new_cust.php'), body: {
      "id_user": id,
      "company": company.text,
      "name": name.text,
      "hp": hp.text,
      "button": button,
      "email": email.text,
      "category": category.text,
      "id_cust": widget.list['id_cust'],
    });
    log(response.body);

    if (json.decode(response.body) == 0) {
      Fluttertoast.showToast(
          msg: "Data successfully created.", toastLength: Toast.LENGTH_SHORT);
      Navigator.of(context).pushNamed('home');
    } else {
      Fluttertoast.showToast(msg: "error", toastLength: Toast.LENGTH_SHORT);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.0), // here the desired height
            child: AppBar(
              elevation: 0,
              centerTitle: true,
              title: Center(child: Text('Edit Client')),
              actions: [
                Container(
                  padding: EdgeInsets.only(right: 20),
                  child: Icon(
                    Icons.notifications_none_outlined,
                    size: 35,
                    color: Colors.transparent,
                  ),
                )
              ],
              flexibleSpace: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topLeft,
                        colors: [
                      Colors.blue,
                      Colors.white,
                    ])),
              ),
            )),
        bottomNavigationBar: MyNavigationBar('home'),
        drawer: MyDrawer(),
        body: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0),
              ),
              color: Colors.white),
          child: ListView(
            padding: EdgeInsets.only(bottom: 30),
            children: [
              Container(
                child: Row(
                  children: [],
                ),
              ),
              textbuild('Company'),
              bulidTextField('Company Name', company, TextInputType.text),
              textbuild('Client Name'),
              bulidTextField(' Name', name, TextInputType.text),
              textbuild('Contact HP'),
              bulidTextField('Contact ', hp, TextInputType.number),
              textbuild('Email'),
              bulidTextField('exampel@gmail.com', email, TextInputType.text),
              textbuild('Category'),
              bulidTextField('Category', category, TextInputType.text),
              Padding(
                padding: EdgeInsets.only(top: 30),
              ),
              Column(
                children: [
                  Container(
                    height: 40,
                    width: 170,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),

                      onPressed: () {
                        updateche(idUser, buttonText);
                      },
                      // Refer step 3
                      child: Text(
                        buttonText,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),

                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Container textbuild(String mytext) {
    return Container(
        margin: EdgeInsets.only(left: 30, top: 20),
        child: Text(
          mytext,
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
        ));
  }

  Container bulidTextField(
      String myhintText, TextEditingController mycontroller, roomKeyboardType) {
    return Container(
      height: 50,
      margin: EdgeInsets.only(left: 30, right: 30, top: 5),
      child: TextField(
        controller: mycontroller,
        keyboardType: roomKeyboardType,
        decoration: new InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.black, width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.grey, width: 1.0),
            ),
            hintText: myhintText,
            hintStyle: TextStyle(color: Colors.blueAccent[100], fontSize: 14)),
      ),
    );
  }
}
