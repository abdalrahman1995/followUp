import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:followup/drawer.dart';
import 'package:followup/insert/edit_action.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'action_info.dart';
import 'add_action.dart';
import 'navigationbar.dart';

class CustInfo extends StatefulWidget {
  // CustInfo({Key? key}) : super(key: key);

  final Map<String, dynamic> list;
  final int index;
  CustInfo({required this.index, required this.list});

  @override
  _CustInfoState createState() => _CustInfoState();
}

Future getAllData(String idCust) async {
  var response = await http.post(
      Uri.https('followup.my', '/process/app/p.id_cust_table_app.php'),
      body: {"id_cust": idCust});

  // print(response.body);
  if (response.body.isEmpty) {
    return null;
  } else {
    return json.decode(response.body);
  }
}

class _CustInfoState extends State<CustInfo> {
  get index => null;

  get list => null;

  @override
  void initState() {
    getAllData(widget.list['id_cust']);

    super.initState();
  }

  Future deleteData(String id) async {
    var response = await http
        .post(Uri.https('followup.my', '/process/app/p.delete.php'), body: {
      "id_action": id,
      "table": "actions",
    });

    if (response.body == '0') {
      setState(() {
        getAllData(widget.list['id_cust']);
      });
    } else {
      print('failed to delete');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbarbuilder(widget.list['name']),
        drawer: MyDrawer(),
        backgroundColor: Colors.white,
        bottomNavigationBar: MyNavigationBar('home'),
        body: Column(
          children: [
            Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Container(
                      height: 42,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                              child: Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Text('Name:'))),
                          Expanded(
                              child:
                                  Container(child: Text(widget.list['name']))),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Divider(
                        height: 1,
                      ),
                    ),
                    // Container(
                    //   height: 42,
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //     children: [
                    //       Expanded(
                    //           child: Container(
                    //               margin: EdgeInsets.only(left: 20),
                    //               child: Text('Last Update:'))),
                    //       Expanded(
                    //           child: Container(
                    //               child: Text(widget.list['updated']
                    //                   .substring(0, 10)))),
                    //     ],
                    //   ),
                    // ),
                    // Container(
                    //   padding: EdgeInsets.only(left: 10, right: 10),
                    //   child: Divider(
                    //     height: 1,
                    //   ),
                    // ),
                    Container(
                      height: 42,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                              child: Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Text('Email:'))),
                          Expanded(
                              child:
                                  Container(child: Text(widget.list['email']))),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Divider(
                        height: 1,
                      ),
                    ),
                    Container(
                      height: 42,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                              child: Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Text('Contact:'))),
                          Expanded(
                              child: Container(child: Text(widget.list['hp']))),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Divider(
                        height: 1,
                      ),
                    ),
                    Container(
                      height: 42,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                              child: Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Text('Company:'))),
                          Expanded(
                              child:
                                  Container(child: Text(widget.list['comp']))),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Divider(
                        height: 1,
                      ),
                    ),
                    Container(
                      height: 42,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                              child: Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Text('Category:'))),
                          Expanded(
                              child: Container(
                                  child: Text(widget.list['category']))),
                        ],
                      ),
                    ),
                  ],
                )),
            Container(
              color: Color(0xFFe8e5dc),
              height: 10,
              // margin: EdgeInsets.only(left: 60, right: 60),
            ),
            Expanded(
                flex: 4,
                child: Column(
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
                      flex: 4,
                      child: Container(
                        child: FutureBuilder(
                          future: getAllData(widget.list['id_cust']),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasError) print(snapshot.error);
                            return snapshot.hasData
                                ? ListView.builder(
                                    padding:
                                        EdgeInsets.only(bottom: 70, top: 0),
                                    itemCount: snapshot.data?.length,
                                    itemBuilder: (context, index) {
                                      List list = snapshot.data;
                                      return InkWell(
                                        child: Slidable(
                                          actionPane:
                                              SlidableDrawerActionPane(),
                                          secondaryActions: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 5, bottom: 7),
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
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return AlertDialog(
                                                                    scrollable:
                                                                        true,
                                                                    title:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        'Are Sure you want to Delete it?',
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    content:
                                                                        Container(
                                                                      padding: EdgeInsets.only(
                                                                          left:
                                                                              20,
                                                                          right:
                                                                              20),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        children: [
                                                                          ElevatedButton(
                                                                              style: ElevatedButton.styleFrom(
                                                                                primary: Colors.grey,
                                                                              ),
                                                                              child: Text("Cancel"),
                                                                              onPressed: () {
                                                                                Navigator.of(context).pop();
                                                                              }),
                                                                          ElevatedButton(
                                                                            style:
                                                                                ElevatedButton.styleFrom(
                                                                              primary: Colors.red,
                                                                            ),
                                                                            child:
                                                                                Text("Delete"),
                                                                            onPressed:
                                                                                () {
                                                                              deleteData(list[index]["id_action"]);

                                                                              Navigator.of(context).pop();
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
                                                        color: Colors
                                                            .blueAccent[200],
                                                        icon: Icons.edit,
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          EditAction(
                                                                            index:
                                                                                index,
                                                                            list:
                                                                                list[index],
                                                                            idCust:
                                                                                widget.list['id_cust'],
                                                                          )));
                                                        }),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                          child: Container(
                                              margin: EdgeInsets.only(
                                                  left: 15, right: 15, top: 10),
                                              height: 75,
                                              decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                  color: Colors.black12,
                                                )),
                                              ),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: Column(
                                                      children: [
                                                        Expanded(
                                                            flex: 1,
                                                            child: Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: 10,
                                                                      top: 0,
                                                                      bottom:
                                                                          10),
                                                              child: SizedBox(
                                                                child: ListView(
                                                                  children: [
                                                                    Container(
                                                                      child:
                                                                          Text(
                                                                        list[index]
                                                                            [
                                                                            'content'],
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              11,
                                                                        ),
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        overflow:
                                                                            TextOverflow.fade,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Column(
                                                      children: [
                                                        Expanded(
                                                            flex: 1,
                                                            child: Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                left: 20,
                                                              ),
                                                              child: Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child: Text(
                                                                  list[index][
                                                                      'medium'],
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                  ),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .fade,
                                                                  softWrap:
                                                                      false,
                                                                ),
                                                              ),
                                                            )),
                                                        Expanded(
                                                            flex: 1,
                                                            child: Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                left: 20,
                                                              ),
                                                              child: Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child: Text(
                                                                  list[index][
                                                                          'updated']
                                                                      .substring(
                                                                          0,
                                                                          10),
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                  ),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .fade,
                                                                  softWrap:
                                                                      false,
                                                                ),
                                                              ),
                                                            )),
                                                        Expanded(
                                                            flex: 1,
                                                            child: Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                left: 20,
                                                              ),
                                                              child: Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child: Text(
                                                                  list[index]
                                                                      ['type'],
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                  ),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .fade,
                                                                  softWrap:
                                                                      false,
                                                                ),
                                                              ),
                                                            )),
                                                        Expanded(
                                                            flex: 1,
                                                            child: Container(
                                                              child: Align(
                                                                alignment: Alignment
                                                                    .bottomRight,
                                                                child: Text(
                                                                  list[index][
                                                                          'follow']
                                                                      .substring(
                                                                          5,
                                                                          10),
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        10,
                                                                    color: Colors
                                                                            .grey[
                                                                        500],
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .fade,
                                                                  softWrap:
                                                                      false,
                                                                ),
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
                                                  builder: (context) =>
                                                      ActionInfo(
                                                        index: index,
                                                        list: list[index],
                                                      )));
                                        },
                                      );
                                    })
                                : Container(
                                    child: Center(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                            child: Image(
                                              image: AssetImage(
                                                'images/data.png',
                                              ),
                                              width: 230,
                                              height: 210,
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              'No data added',
                                              // AppLocalizations.of(context).noData,

                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                          },
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(15.0),
        //   ),
        //   backgroundColor: Colors.blue[300],
        //   onPressed: () {
        //     Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) => NewAction(
        //               idCust: widget.list['id_cust'],
        //               index: index,
        //               list: list[index]),
        //         ));
        //   },
        //   child: Icon(
        //     Icons.add,
        //     size: 35,
        //   ),
        // ),
        floatingActionButton: Container(
          margin: EdgeInsets.only(left: 30),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            FloatingActionButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Icon(Icons.refresh),
              onPressed: () {
                setState(() {
                  getAllData(widget.list['id_cust']);
                });
                Fluttertoast.showToast(
                    msg: "Refreshed", toastLength: Toast.LENGTH_LONG);
              },
              heroTag: null,
            ),
            FloatingActionButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Icon(
                Icons.add,
                size: 35,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddAction(
                        idCust: widget.list['id_cust'],
                        list: {},
                      ),
                    ));
              },
              heroTag: null,
            )
          ]),
        ));
  }

  PreferredSize appbarbuilder(String name) {
    return PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Center(
              child: Text(
            name,
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
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
          actions: [
            Container(
              padding: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.notifications_none_outlined,
                size: 35,
                color: Colors.transparent,
              ),
            )
          ],
        ));
  }
}
