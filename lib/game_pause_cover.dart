import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GamePauseCoverPage extends StatefulWidget {
  GamePauseCoverPage({Key? key, required this.bg}) : super(key: key);
  final String bg;

  @override
  _GamePauseCoverPageState createState() => _GamePauseCoverPageState();
}

class _GamePauseCoverPageState extends State<GamePauseCoverPage> {
  @override
  Widget build(BuildContext context) {
    TextStyle pageTextStyle = TextStyle(color: Colors.white);

    Widget bodyView = Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
          child: CupertinoButton(
        borderRadius: BorderRadius.circular(30.0),
        color: Color(0xffFF9C76),
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(
          "Continue",
          style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      )),
    ]));

    var onTap = () {
      Navigator.pop(context);
    };
    return GestureDetector(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/image/${widget.bg}.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Scaffold(
              backgroundColor: Colors.transparent,
              body: DefaultTextStyle(child: bodyView, style: pageTextStyle)),
        ),
        onTap: onTap);
  }
}
