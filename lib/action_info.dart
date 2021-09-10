import 'package:flutter/material.dart';
import 'package:followup/drawer.dart';
import 'navigationbar.dart';

class ActionInfo extends StatefulWidget {
  // CustInfo({Key? key}) : super(key: key);

  final Map<String, dynamic> list;
  final int index;
  ActionInfo({required this.index, required this.list});

  @override
  _ActionInfoState createState() => _ActionInfoState();
}

class _ActionInfoState extends State<ActionInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarbuilder(widget.list['cust_name'] + "  " + "Details "),
      drawer: MyDrawer(),
      bottomNavigationBar: MyNavigationBar('action'),
      body: Column(
        children: [
          Expanded(
              flex: 1,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topLeft,
                              colors: [
                                Colors.white,
                                Color(0xFFE1F5FE),
                              ])),
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                              child: Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Text(
                                    'Name :',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ))),
                          Expanded(
                              flex: 2,
                              child: Container(
                                  child: Text(widget.list['cust_name']))),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topLeft,
                              colors: [
                                Colors.white,
                                Color(0xFFE1F5FE),
                              ])),
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                              child: Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Text(
                                    'Date Start :',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ))),
                          Expanded(
                              flex: 2,
                              child: Container(
                                  child: Text(widget.list['updated']
                                      .substring(0, 10)))),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 40,
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topLeft,
                              colors: [
                                Colors.white,
                                Color(0xFFE1F5FE),
                              ])),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                              flex: 1,
                              child: Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Text(
                                    'Type :',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ))),
                          Expanded(
                              flex: 2,
                              child:
                                  Container(child: Text(widget.list['type']))),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 40,
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topLeft,
                              colors: [
                                Colors.white,
                                Color(0xFFE1F5FE),
                              ])),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                              child: Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Text(
                                    'Contact :',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ))),
                          Expanded(
                              flex: 2,
                              child: Container(child: Text(widget.list['hp']))),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 40,
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topLeft,
                              colors: [
                                Colors.white,
                                Color(0xFFE1F5FE),
                              ])),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                              child: Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Text(
                                    'Action :',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ))),
                          Expanded(
                              flex: 2,
                              child: Container(
                                  child: Text(widget.list['medium']))),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topLeft,
                              colors: [
                                Colors.white,
                                Color(0xFFE1F5FE),
                              ])),
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                              child: Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                                margin: EdgeInsets.only(left: 20),
                                child: Text(
                                  'Content :',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                          )),
                          Expanded(
                              flex: 2,
                              child: SizedBox(
                                  height: 225.0,
                                  child: ListView(
                                    children: [
                                      Container(
                                          child: Text(widget.list['content'])),
                                    ],
                                  ))),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(15.0),
      //   ),
      //   backgroundColor: Colors.blue[300],
      //   onPressed: () {
      //     Navigator.of(context).pushNamed('new_action');
      //   },
      //   child: Icon(
      //     Icons.add,
      //     size: 35,
      //   ),
      // ),
    );
  }

  PreferredSize appbarbuilder(String name) {
    return PreferredSize(
        preferredSize: Size.fromHeight(60.0), // here the desired height
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
