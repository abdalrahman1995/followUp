import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../drawer.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../navigationbar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String typeUpdate = '';
String actionType = '';
String idUser = '';
List<Map<String, String>> acType = [
  {
    "name": "I called",
    "id": "call",
  },
  {
    "name": "I sent email",
    "id": "email",
  },
  {
    "name": "I sent Whatsapp",
    "id": "whatsapp",
  },
  {
    "name": "I did video call",
    "id": "video",
  },
  {
    "name": "just an update",
    "id": "update",
  },
  {
    "name": "Successfully Closed",
    "id": "close",
  },
];
List<Map<String, String>> upType = [
  {
    "name": "Individual",
    "id": "0",
  },
  {
    "name": "Individual",
    "id": "0",
  },
  {
    "name": "Individual",
    "id": "0",
  },
  {
    "name": "Individual",
    "id": "0",
  },
  {
    "name": "Individual",
    "id": "0",
  },
  {
    "name": "Team",
    "id": "1",
  },
];

class EditAction extends StatefulWidget {
  final Map<String, dynamic> list;
  final int index;
  final String idCust;
  EditAction({required this.idCust, required this.index, required this.list});

  @override
  _EditActionState createState() => _EditActionState();
}

String formattedDate = DateFormat('yyyy-MM-dd H:m:s').format(today);

DateTime today = DateTime.now();

class _EditActionState extends State<EditAction> {
  late TextEditingController comment;

  @override
  void initState() {
    getValidtionData();
    idUser = '1';
    comment = new TextEditingController();
    // ignore: unnecessary_null_comparison
    // if (widget.index != null) {
    //
    // typeUpdate = widget.list['type'];
    // actionType = widget.list['medium'];

    comment.text = widget.list['content'];
    // }

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
      "id_action": widget.list['id_action'],
      "type": typeUpdate,
      "medium": actionType,
      "content": comment.text,
      "follow": formattedDate,
      "button": "Update",
    });
    print(response.body);

    if (json.decode(response.body) == 0) {
      Fluttertoast.showToast(
          msg: "Data successfully upladed.", toastLength: Toast.LENGTH_SHORT);
      Navigator.of(context).pushNamed("action");
      // Navigator.of(context).pop();
      // Navigator.of(context).pop();
    } else {
      Fluttertoast.showToast(msg: "error", toastLength: Toast.LENGTH_SHORT);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.0), // here the desired height
            child: AppBar(
              elevation: 0,
              centerTitle: true,
              title: Center(
                  child: Text(
                'Edit Action',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
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
        body: ListView(
          padding: EdgeInsets.only(bottom: 30),
          children: [
            textbuild('What type of update is this?'),
            Container(
              margin: EdgeInsets.only(left: 30, right: 30, top: 5),
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.black, width: 1.0)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                ),
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.blue,
                ),
                iconSize: 25,
                isExpanded: true,
                // value: typeUpdate,
                items: [
                  "I called",
                  "I sent email",
                  'I sent Whatsapp',
                  'I did video call',
                  'I met the person',
                  'just an update',
                  'Successfully closed'
                ]
                    .map((label) => DropdownMenuItem(
                        child: Text(
                          label.toString(),
                        ),
                        value: label))
                    .toList(),
                hint: Text(
                  typeUpdate = widget.list['type'],
                  style: TextStyle(color: Colors.blueAccent[100], fontSize: 14),
                ),
                onChanged: (value) {
                  setState(() {
                    // typeUpdate = value;
                  });
                },
              ),
            ),
            textbuild('Comments'),
            bulidTextField(' Comments', comment),
            textbuild('Next course of action?'),
            Container(
              margin: EdgeInsets.only(left: 30, right: 30, top: 5),
              child: DropdownButtonFormField<dynamic>(
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.black, width: 1.0)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                ),
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.blue,
                ),
                iconSize: 25,
                isExpanded: true,
                // value: actionType,
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
                  actionType = widget.list['medium'],
                  style: TextStyle(color: Colors.blueAccent[100], fontSize: 14),
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
            Container(
              height: 200,
              color: Colors.white,
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
                      updateche(idUser);
                    },
                    // Refer step 3
                    child: Text(
                      'Update Action',
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
            // Container(
            //   color: Colors.white,
            //   margin: EdgeInsets.only(top: 15, bottom: 15, left: 80, right: 60),
            //   height: 40,
            //   width: 170,
            //   child: MaterialButton(
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(10.0),
            //     ),

            //     onPressed: () {
            //       setState(() {
            //         updateche(idUser);
            //       });
            //     },
            //     // Refer step 3
            //     child: Text(
            //       "Update",
            //       style: TextStyle(
            //           color: Colors.white,
            //           fontSize: 14,
            //           fontWeight: FontWeight.bold),
            //     ),

            //     color: Colors.blue,
            //   ),
            // ),
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
      // height: 55,
      margin: EdgeInsets.only(left: 30, right: 30, top: 5),
      child: TextField(
        minLines: 1,
        maxLines: 50,
        // ignore: deprecated_member_use
        maxLengthEnforced: true,
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
