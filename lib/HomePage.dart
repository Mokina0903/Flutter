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
  bool isCross = false;

  void playGame(int index) {
    if (this.gameState[index] == "empty") {
      setState(() {
        this.isCross
            ? this.gameState[index] = "cross"
            : this.gameState[index] = "circle";
      });
      this.isCross = ! this.isCross;
      this.checkWin();
    }
  }

  void checkWin() {

  }

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

  AssetImage getImage(String value) {
    switch (value) {
      case ('cross'):
        return cross;
        break;
      case ('circle'):
        return circle;
        break;
      default:
        return edit;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Tic Tac Toe", style: TextStyle(
          color: Colors.white,
        ),),
        backgroundColor: Color(0xFF192A56),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(20.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0),
              itemCount: this.gameState.length,
              itemBuilder: (context, i) => SizedBox(
                width: 100.0,
                height: 100.0,
                child: MaterialButton(
                  onPressed: () {
                    this.playGame(i);
                  },
                  child: Image(
                    image: this.getImage(this.gameState[i]),
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: Text(
              this.message,
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(32.0),
            child: MaterialButton(
              padding: EdgeInsets.all(20.0),
              color: Color(0xFF0A3D62),
              minWidth: 300.0,
              height: 50.0,
              child: Text(
                "Reset Game",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                this.resetGame();
              },
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          )
        ],
      ),
    );
  }
}