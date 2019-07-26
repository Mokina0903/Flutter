import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AssetImage cross = AssetImage("images/cross.png");
  AssetImage circle = AssetImage("images/circle.png");

  String message;
  bool isCross;
  bool gameFinished;
  List<List<String>> gameState;

  @override
  void initState() {
    super.initState();
    _newGame();
  }

  void _newGame() {
    setState(() {
      this.gameState = [
        ["empty", "empty", "empty"],
        ["empty", "empty", "empty"],
        ["empty", "empty", "empty"],
      ];
      this.message = "";
      this.isCross = true;
      this.gameFinished = false;
    });
  }

  void playGame(int x, int y) {
    if (this.gameState[x][y] == "empty") {
      setState(() {
        this.isCross
            ? this.gameState[x][y] = "cross"
            : this.gameState[x][y] = "circle";
      });
      this.isCross = !this.isCross;
      this._checkWin(x, y);
    }
  }

  void _checkWin(int x, int y) {
    int col = 0, row = 0;
    int diag = 0, rdiag = 0;
    int n = this.gameState.length - 1;
    String player = this.gameState[x][y];

    int fullRow = 0;
    this.gameState.forEach((row) => {
      if (!row.contains('empty'))
        fullRow++
    });

    if (fullRow >= this.gameState.length) {
      setState((){
        this.message = 'Draw...';
        _delay();
      });
    }

    for (int i = 0; i <= n; i++) {
    if (this.gameState[x][i] == player)
      col++;
    if (this.gameState[i][y] == player)
      row++;
    if (this.gameState[i][i] == player)
      diag++;
    if (this.gameState[i][n-i] == player)
      rdiag++;
    }

    if (col == this.gameState.length || row == this.gameState.length ||
      diag == this.gameState.length || rdiag == this.gameState.length) {
      setState(() {
        this.message = "Player $player won!";
        _delay();
      });
    }
  }

  void _delay() {
    setState(() {
      this.gameFinished = true;
    });
    Future.delayed(const Duration(milliseconds: 1600), () {
      _newGame();
    });
  }

  AssetImage _getImage(String value) {
    switch (value) {
      case ('cross'):
        return cross;
        break;
      case ('circle'):
        return circle;
        break;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    print(this.gameFinished);
    return Scaffold(
      appBar: new AppBar(
        title: Text(
          "Tic Tac Toe",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
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
              itemCount: this.gameState.length * this.gameState.length,
              itemBuilder: _buildGridRow,
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
                this._newGame();
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

  Widget _buildGridRow(BuildContext context, int index) {
    int gridStateLength = gameState.length;
    int x, y = 0;
    x = (index / gridStateLength).floor();
    y = (index % gridStateLength);
    return GestureDetector(
      child: Container(
        child: Center(
          child: _buildGridCell(x, y),
        ),
      ),
    );
  }

  Widget _buildGridCell(int x, int y) {
    return SizedBox(
      width: 100.0,
      height: 100.0,
      child: IgnorePointer(
        ignoring: this.gameFinished,
        child: MaterialButton(
          color: Colors.indigoAccent[100],
          onPressed: () {
            this.playGame(x, y);
          },
          child: this._getImage(this.gameState[x][y]) == null
              ? null
              : Image(
            image: this._getImage(this.gameState[x][y]),
          ),
        ),
      ),
    );
  }
}
