import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:followup/drawer.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'info.dart';
import 'insert/new_client.dart';
import 'navigationbar.dart';

String idUser = '';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

Future getAllData(id) async {
  var response = await http.post(
      Uri.https('followup.my', '/process/app/p.cust_table_app.php'),
      body: {"id_user": id});

  // print(response.body);
  if (response.body.isEmpty) {
    return null;
  } else {
    return json.decode(response.body);
  }
}

class _HomeState extends State<Home> {
  Widget appBarTitle = new Text(
    "Follow Up",
    style: TextStyle(fontWeight: FontWeight.bold),
  );
  Icon actionIcon = new Icon(Icons.search);
  late TextEditingController _searchController;

  @override
  void initState() {
    getValidtionData();
    idUser = '0';
    super.initState();
    _searchController = TextEditingController();
  }

  Future deleteData(String id) async {
    var response = await http
        .post(Uri.https('followup.my', '/process/app/p.delete.php'), body: {
      "id_cust": id,
      "table": "follow_cust",
    });

    if (response.body == '0') {
      setState(() {
        getAllData(idUser);
      });
    } else {
      print('failed to delete');
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
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: appbarbuilder(),
          drawer: MyDrawer(),
          backgroundColor: Colors.white,
          bottomNavigationBar: MyNavigationBar('home'),
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
              //                 'Company',
              //                 textAlign: TextAlign.center,
              //               )),
              //           // Expanded(
              //           //     flex: 1,
              //           //     child: Text(
              //           //       'Email',
              //           //       textAlign: TextAlign.center,
              //           //     )),
              //         ],
              //       )),
              // ),
              Expanded(
                child: FutureBuilder(
                  future: getAllData(idUser),
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
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                            scrollable: true,
                                                            title: Center(
                                                              child: Text(
                                                                'Are Sure you want to Delete it?',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                            ),
                                                            content: Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 20,
                                                                      right:
                                                                          20),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  ElevatedButton(
                                                                      style: ElevatedButton
                                                                          .styleFrom(
                                                                        primary:
                                                                            Colors.grey,
                                                                      ),
                                                                      child: Text(
                                                                          "Cancel"),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      }),
                                                                  ElevatedButton(
                                                                    style: ElevatedButton
                                                                        .styleFrom(
                                                                      primary:
                                                                          Colors
                                                                              .red,
                                                                    ),
                                                                    child: Text(
                                                                        "Delete"),
                                                                    onPressed:
                                                                        () {
                                                                      deleteData(
                                                                          list[index]
                                                                              [
                                                                              "id_cust"]);

                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                  ),
                                                                ],
                                                              ),
                                                            ));
                                                      });
                                                }),
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
                                                              NewClient(
                                                                index: index,
                                                                list:
                                                                    list[index],
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
                                        // color: Colors.white,
                                        // boxShadow: [
                                        //   BoxShadow(
                                        //     blurRadius: 1,
                                        //     color: Colors.black12,
                                        //     spreadRadius: 1,
                                        //     offset:
                                        //         Offset(0, 0), // Shadow position
                                        //   ),
                                        // ]
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
                                                        list[index]['comp'],
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
                                                          right: 10, top: 10),
                                                      child: Text(
                                                        list[index]['name'],
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
                                                        list[index]['email'],
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
                                          builder: (context) => CustInfo(
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
                              'No Client Added',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                          );
                  },
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            backgroundColor: Colors.blue[300],
            onPressed: () {
              Navigator.of(context).pushNamed('add_cust');
            },
            child: Icon(
              Icons.add,
              size: 35,
            ),
          ),
        ));
  }

  PreferredSize appbarbuilder() {
    return PreferredSize(
        preferredSize: Size.fromHeight(60.0),
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
                      controller: _searchController,
                      style: new TextStyle(
                        color: Colors.white,
                      ),
                      decoration: new InputDecoration(
                          prefixIcon:
                              new Icon(Icons.search, color: Colors.white),
                          hintText: "Search on clients...",
                          hintStyle: new TextStyle(color: Colors.white)),

                      // can add a trigger here where if i click search icon after entering any text, it prints that text, later i can replace with the correct search code
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
