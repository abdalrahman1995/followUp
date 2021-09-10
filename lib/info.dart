import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:followup/drawer.dart';
import 'package:followup/insert/new_action.dart';
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
        bottomNavigationBar: MyNavigationBar('home'),
        body: Column(
          children: [
            Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Container(
                      height: 40,
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
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                              child: Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Text('Date Start:'))),
                          Expanded(
                              child: Container(
                                  child: Text(widget.list['updated']
                                      .substring(0, 10)))),
                        ],
                      ),
                    ),
                    Container(
                      height: 40,
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
                      height: 40,
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
                      height: 40,
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
                      height: 40,
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
            Expanded(
                flex: 4,
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                          margin: EdgeInsets.only(top: 10, left: 5, right: 5),
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              // color: Colors.white,
                              gradient: LinearGradient(
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topLeft,
                                  colors: [
                                    Colors.white70,
                                    Colors.white,
                                  ]),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 1,
                                  color: Colors.blue,
                                  spreadRadius: 1,
                                  offset: Offset(0, 0), // Shadow position
                                ),
                              ]),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    'Client Name',
                                    textAlign: TextAlign.center,
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    'Action',
                                    textAlign: TextAlign.center,
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    'Date',
                                    textAlign: TextAlign.center,
                                  )),
                            ],
                          )),
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                        child: FutureBuilder(
                          future: getAllData(widget.list['id_cust']),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasError) print(snapshot.error);
                            return snapshot.hasData
                                ? ListView.builder(
                                    padding: EdgeInsets.only(bottom: 60),
                                    itemCount: snapshot.data?.length,
                                    itemBuilder: (context, index) {
                                      List list = snapshot.data;
                                      return InkWell(
                                        child: Slidable(
                                          actionPane:
                                              SlidableDrawerActionPane(),
                                          secondaryActions: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(top: 8),
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
                                                                          NewAction(
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
                                                  top: 10, left: 15, right: 15),
                                              height: 44,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      blurRadius: 1,
                                                      color: Colors.black12,
                                                      spreadRadius: 1,
                                                      offset: Offset(0,
                                                          0), // Shadow position
                                                    ),
                                                  ]),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.all(5),
                                                        child: Text(
                                                          list[index]
                                                              ['cust_name'],
                                                          textAlign:
                                                              TextAlign.center,
                                                          overflow:
                                                              TextOverflow.fade,
                                                          softWrap: false,
                                                        ),
                                                      )),
                                                  Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.all(5),
                                                        child: Text(
                                                          list[index]['medium'],
                                                          textAlign:
                                                              TextAlign.center,
                                                          overflow:
                                                              TextOverflow.fade,
                                                          softWrap: false,
                                                        ),
                                                      )),
                                                  Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.all(5),
                                                        child: Text(
                                                          list[index]['updated']
                                                              .substring(0, 10),
                                                          textAlign:
                                                              TextAlign.center,
                                                          overflow:
                                                              TextOverflow.fade,
                                                          softWrap: false,
                                                        ),
                                                      )),
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
