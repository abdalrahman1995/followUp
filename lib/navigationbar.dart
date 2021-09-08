import 'package:flutter/material.dart';

class MyNavigationBar extends StatefulWidget {
  final String highlight; //try
  const MyNavigationBar(this.highlight); //try

  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            MaterialButton(
              onPressed: () {
                setState(() {
                  Navigator.pushNamedAndRemoveUntil(
                      context, "home", (r) => false);
                  // Navigator.of(context).pushNamed('home');
                });
              },
              child: Icon(Icons.home_outlined,
                  size: 40,
                  color:
                      widget.highlight == 'home' ? Colors.blue : Colors.grey),
            ),
            MaterialButton(
              onPressed: () {
                setState(() {
                  Navigator.pushNamedAndRemoveUntil(
                      context, "action", (r) => false);
                  // Navigator.of(context).pushNamed('action');
                });
              },
              child: Icon(Icons.list_alt_outlined,
                  size: 40,
                  color:
                      widget.highlight == 'action' ? Colors.blue : Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
