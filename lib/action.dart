import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:followup/drawer.dart';
import 'package:followup/insert/new_action.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'action_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'navigationbar.dart';

String idUser = '';

class ActionList extends StatefulWidget {
  ActionList({Key? key}) : super(key: key);

  @override
  _ActionListState createState() => _ActionListState();
}

Future getAllData(id) async {
  var response = await http.post(
      Uri.https('followup.my', '/process/app/p.action_table_app.php'),
      body: {"id_user": id});
  // print(response.body);
  if (response.body.isEmpty) {
    return null;
  } else {
    return json.decode(response.body);
  }
}

class _ActionListState extends State<ActionList> {
  Widget appBarTitle = new Text(
    "Follow Up",
    style: TextStyle(fontWeight: FontWeight.bold),
  );
  Icon actionIcon = new Icon(Icons.search);
  late TextEditingController search;
  @override
  void initState() {
    getValidtionData();
    idUser = '1';
    search = new TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: appbarbuilder(),
          drawer: MyDrawer(),
          backgroundColor: Colors.white,
          bottomNavigationBar: MyNavigationBar('action'),
          body: Column(
            children: [
              // Expanded(
              //   flex: 1,
              //   child: Container(
              //       margin: EdgeInsets.only(top: 10, left: 5, right: 5),
              //       height: 50,
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(10),
              //           // color: Colors.white,
              //           gradient: LinearGradient(
              //               begin: Alignment.bottomLeft,
              //               end: Alignment.topLeft,
              //               colors: [
              //                 Colors.white70,
              //                 Colors.white,
              //               ]),
              //           boxShadow: [
              //             BoxShadow(
              //               blurRadius: 1,
              //               color: Colors.blue,
              //               spreadRadius: 1,
              //               offset: Offset(0, 0), // Shadow position
              //             ),
              //           ]),
              //       child: Row(
              //         children: [
              //           Expanded(
              //               flex: 1,
              //               child: Text(
              //                 'Client Name',
              //                 textAlign: TextAlign.center,
              //               )),
              //           Expanded(
              //               flex: 1,
              //               child: Text(
              //                 'Action',
              //                 textAlign: TextAlign.center,
              //               )),
              //           Expanded(
              //               flex: 1,
              //               child: Text(
              //                 'Date',
              //                 textAlign: TextAlign.center,
              //               )),
              //         ],
              //       )),
              // ),
              Expanded(
                child: FutureBuilder(
                  future: getAllData(idUser),
                  // initialData: InitialData,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasError) print(snapshot.error);
                    return snapshot.hasData
                        ? ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              List list = snapshot.data;
                              return InkWell(
                                child: Slidable(
                                  actionPane: SlidableDrawerActionPane(),
                                  secondaryActions: <Widget>[
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 10, bottom: 10),
                                      padding: EdgeInsets.all(2),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: IconSlideAction(
                                                caption: "Delete",
                                                color: Colors.red,
                                                icon: Icons.delete,
                                                onTap: () {}),
                                          ),
                                          Expanded(
                                            child: IconSlideAction(
                                                caption: "Edit",
                                                color: Colors.blueAccent[200],
                                                icon: Icons.edit,
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              NewAction(
                                                                index: index,
                                                                list:
                                                                    list[index],
                                                                idCust: '',
                                                              )));
                                                }),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                  child: Container(
                                      margin:
                                          EdgeInsets.only(left: 15, right: 15),
                                      height: 75,
                                      decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                          color: Colors.black12,
                                        )),
                                      ),
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      padding: EdgeInsets.only(
                                                          left: 10, top: 10),
                                                      child: Text(
                                                        list[index]
                                                            ['cust_name'],
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                        textAlign:
                                                            TextAlign.left,
                                                        overflow:
                                                            TextOverflow.fade,
                                                        softWrap: false,
                                                      ),
                                                    )),
                                                Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      padding: EdgeInsets.only(
                                                          right: 30, top: 10),
                                                      child: Text(
                                                        list[index]['medium'],
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                        textAlign:
                                                            TextAlign.right,
                                                        overflow:
                                                            TextOverflow.fade,
                                                        softWrap: false,
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      padding: EdgeInsets.only(
                                                          left: 10,
                                                          top: 5,
                                                          bottom: 5),
                                                      child: Text(
                                                        list[index]['follow'],
                                                        style: TextStyle(
                                                            color: Colors
                                                                .blue[300],
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                        textAlign:
                                                            TextAlign.left,
                                                        overflow:
                                                            TextOverflow.fade,
                                                        softWrap: false,
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ActionInfo(
                                                index: index,
                                                list: list[index],
                                              )));
                                },
                              );
                            })
                        : Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(top: 20),
                            child: Text(
                              'No Action Added',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                          );
                  },
                ),
              )
            ],
          ),
        ));
  }

  PreferredSize appbarbuilder() {
    return PreferredSize(
        preferredSize: Size.fromHeight(60.0), // here the desired height
        child: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Center(child: appBarTitle),
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
          backgroundColor: Colors.green[400],
          actions: <Widget>[
            new IconButton(
              icon: actionIcon,
              onPressed: () {
                setState(() {
                  if (this.actionIcon.icon == Icons.search) {
                    this.actionIcon = new Icon(Icons.close);
                    this.appBarTitle = new TextField(
                      style: new TextStyle(
                        color: Colors.white,
                      ),
                      decoration: new InputDecoration(
                          prefixIcon:
                              new Icon(Icons.search, color: Colors.white),
                          hintText: "Search on action...",
                          hintStyle: new TextStyle(color: Colors.white)),
                      controller: search,
                    );
                  } else {
                    this.actionIcon = new Icon(Icons.search);
                    this.appBarTitle = new Text("Follow Up");
                  }
                });
              },
            ),
          ],
        ));
  }
}
