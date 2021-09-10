import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../drawer.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../navigationbar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

var typeUpdate;
var actionType;
String idUser = '';

class AddAction extends StatefulWidget {
  final Map<String, dynamic> list;
  final String idCust;
  AddAction({required this.idCust, required this.list});
  @override
  _AddActionState createState() => _AddActionState();
}

String formattedDate = DateFormat('yyyy-MM-dd H:m:s').format(today);

DateTime today = DateTime.now();

class _AddActionState extends State<AddAction> {
  late TextEditingController comment;

  @override
  void initState() {
    getValidtionData();
    idUser = '1';
    comment = new TextEditingController();

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

  void updateche(id) async {
    // Please check which field is empty string and which field is null when building the form validation checks
    if (formattedDate == '') {
      formattedDate = today.toString();
    }
    if (typeUpdate == '') {
      Fluttertoast.showToast(
          msg: "Please ensure all required fields are completed.",
          toastLength: Toast.LENGTH_LONG);
      return null;
    }
    if (actionType == '') {
      Fluttertoast.showToast(
          msg: "Please ensure all required fields are completed.",
          toastLength: Toast.LENGTH_LONG);
      return null;
    }
    if (comment.text == '') {
      Fluttertoast.showToast(
          msg: "Please ensure all required fields are completed.",
          toastLength: Toast.LENGTH_LONG);
      return null;
    }

    var response = await http
        .post(Uri.https('followup.my', '/process/app/p.new_action.php'), body: {
      "id_cust": widget.idCust,
      "id_user": id,
      "id_action": "",
      "type": typeUpdate,
      "medium": actionType,
      "content": comment.text,
      "follow": formattedDate,
      "button": "Create",
    });
    print(response);

    if (json.decode(response.body) == 0) {
      Fluttertoast.showToast(
          msg: "Data successfully created.", toastLength: Toast.LENGTH_SHORT);
      Navigator.of(context).pop();
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
              title: Center(child: Text('New Action',
            style: TextStyle(fontWeight: FontWeight.bold),)),
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
        bottomNavigationBar: MyNavigationBar('action'),
        drawer: MyDrawer(),
        body: Column(
          children: [
            Expanded(
              child: Container(
                height: 200,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.dateAndTime,
                  initialDateTime: today,
                  onDateTimeChanged: (DateTime newDateTime) {
                    today = newDateTime;
                  },
                  use24hFormat: false,
                  minuteInterval: 1,
                ),
              ),
            ),
            Expanded(
              child: Container(
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
                    textbuild('What type of update is this?'),
                    Container(
                      height: 55,
                      margin: EdgeInsets.only(left: 30, right: 30, top: 5),
                      child: DropdownButtonFormField<dynamic>(
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.0)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                        ),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.blue,
                        ),
                        iconSize: 25,
                        isExpanded: true,
                        value: typeUpdate,
                        items: [
                          "I called ",
                          "I sent email",
                          'I sent Whatsapp',
                          'I did video call',
                          'I met the person',
                          'just an update ',
                          'Closed'
                        ]
                            .map((label) => DropdownMenuItem(
                                  child: Text(
                                    label.toString(),
                                  ),
                                  value: label,
                                ))
                            .toList(),
                        hint: Text(
                          'Select Type',
                          style: TextStyle(
                              color: Colors.blueAccent[100], fontSize: 14),
                        ),
                        onChanged: (value) {
                          setState(() {
                            typeUpdate = value;
                          });
                        },
                      ),
                    ),
                    textbuild('Comments'),
                    bulidTextField(' Comments', comment),
                    textbuild('Next course of action?'),
                    Container(
                      height: 55,
                      margin: EdgeInsets.only(left: 30, right: 30, top: 5),
                      child: DropdownButtonFormField<dynamic>(
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.0)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                        ),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.blue,
                        ),
                        iconSize: 25,
                        isExpanded: true,
                        value: actionType,
                        items: [
                          "Call",
                          "Email",
                          'Whatsapp',
                          'Present',
                          'Video Call',
                          'Forgot It'
                        ]
                            .map((label) => DropdownMenuItem(
                                  child: Text(
                                    label.toString(),
                                  ),
                                  value: label,
                                ))
                            .toList(),
                        hint: Text(
                          'Select Type',
                          style: TextStyle(
                              color: Colors.blueAccent[100], fontSize: 14),
                        ),
                        onChanged: (value) {
                          setState(() {
                            actionType = value;
                          });
                        },
                      ),
                    ),
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
                              setState(() {
                                // print(formattedDate);
                                // print(widget.idCust);
                                updateche(idUser);
                              });
                            },
                            // Refer step 3
                            child: Text(
                              'Create New Action',
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
              ),
            ),
          ],
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
      String myhintText, TextEditingController mycontroller) {
    return Container(
      height: 55,
      margin: EdgeInsets.only(left: 30, right: 30, top: 5),
      child: TextField(
        controller: mycontroller,
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
