import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();

}

class _HomePageState extends State<HomePage>{
  AssetImage cross = AssetImage("images/cross.png");
  AssetImage circle = AssetImage("images/circle.png");
  AssetImage edit = AssetImage("images/edit.png");

  String message;
  List<String> gameState;

  @override
  void initState() {
    super.initState();
    setState(() {
      this.gameState = [
        "empty", "empty", "empty",
        "empty", "empty", "empty",
        "empty", "empty", "empty",
      ];
      this.message = "";
    });
  }

  void resetGame() {
    setState(() {
      this.gameState = [
        "empty", "empty", "empty",
        "empty", "empty", "empty",
        "empty", "empty", "empty",
      ];
      this.message = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

}