import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:games/wzq/wzq_view.dart';

class WuZiQi extends StatefulWidget {
  static const ROUTE_NAME = "/wuziqi";

  @override
  State<StatefulWidget> createState() {
    return WuZiQiState();
  }
}

class WuZiQiState extends State<WuZiQi> {
  Offset offset;
  List<Point> whiteChess = new List();
  List<Point> blackChess = new List();

  double padding;
  double gridWidth;
  double width;

  bool isBlack = true;
  static const BORDER_NUM = 15;

  //0和棋，1黑棋胜 ，-1白棋胜
  int type;
  bool isGameOver = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Size size = MediaQuery.of(context).size;

    width = size.width < size.height ? size.width : size.height;
    gridWidth = width / 15;
    padding = gridWidth / 2;
  }

  @override
  void setState(fn) {
    super.setState(fn);
  }

  checkWin(Point<num> point) {
    var chess = isBlack ? blackChess : whiteChess;
    var bool1 = checkLeftToRight(point, chess);
    var bool2 = checkTopToBottom(point, chess);
    var bool3 = checkLeftTopToRightBottom(point, chess);
    var bool4 = checkLeftBottomToRightTop(point, chess);
    if (bool1 || bool2 || bool3 || bool4) {
      setState(() {
        isGameOver = true;
        if (isBlack) {
          type = 1;
        } else {
          type = -1;
        }
      });
    }
    var bool5 = checkPiece();
    if (bool5) {
      setState(() {
        isGameOver = true;
        type = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("五子棋"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text("${isBlack ? "黑手" : "白手"}"),
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                color: Color(0xffeaa53f),
                child: Center(
                  child: GestureDetector(
                    onTapUp: (detail) {
                      int x = (detail.localPosition.dx ~/ gridWidth);
                      int y = (detail.localPosition.dy ~/ gridWidth);
                      Point point = new Point(x, y);
                      if (blackChess.contains(point) ||
                          whiteChess.contains(point)) {
                        return;
                      }

                      setState(() {
                        if (isBlack) {
                          blackChess.add(point);
                        } else {
                          whiteChess.add(point);
                        }
                        checkWin(point);
                        isBlack = !isBlack;
                      });
                    },
                    child: CustomPaint(
                      size: Size(width, width),
                      painter: WuZiQiView(blackChess, whiteChess),
                    ),
                  ),
                ),
              ),
              buildDialog(),
            ],
          ),
          Row(

            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                color: Color(0xffeaa53f),
                onPressed: () {
                  setState(() {

                    setState(() {
                      if(!isBlack){
                        blackChess.removeLast();
                        isBlack=!isBlack;
                      }else{
                        whiteChess.removeLast();
                        isBlack=!isBlack;
                      }
                    });
                  });
                },
                child: Text("悔棋"),
              ),
              Container(

                width: 30,
              ),
              FlatButton(
                color: Color(0xffeaa53f),
                onPressed: () {
                  setState(() {
                    if(!isBlack){
                      type=1;
                    }else{
                      type=-1;
                    }
                    isGameOver=true;
                  });
                },
                child:  Text("认输"),

              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildDialog() {
    if (isGameOver) {
      return Container(
        color: Color(0x00000000),
        child: Center(
          child: AlertDialog(
            content:
                Text("游戏结束：${type == 0 ? "和棋" : type == 1 ? "黑棋胜" : "白棋胜"}"),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("关闭游戏"),
              ),
              FlatButton(

                onPressed: () {
                  setState(() {
                    whiteChess.clear();
                    blackChess.clear();
                    isGameOver = false;
                    isBlack = true;
                    type = 1;
                  });
                },
                child: Text("再玩一次"),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container(
        width: 0,
        height: 0,
      );
    }
  }

  bool checkLeftToRight(Point<num> point, List<Point<num>> chess) {
    int count = 1;
    for (int i = 1; i < 5; i++) {
      //向左
      if (chess.contains(new Point(point.x - i, point.y))) {
        count++;
      } else {
        break;
      }
    }
    if (count > 4) {
      return true;
    }
    for (int i = 1; i < 5; i++) {
      //向右
      if (chess.contains(new Point(point.x + i, point.y))) {
        count++;
      } else {
        break;
      }
    }
    if (count > 4) {
      return true;
    }
    return false;
  }

  bool checkTopToBottom(Point<num> point, List<Point<num>> chess) {
    var count = 1;
    for (int i = 1; i < 5; i++) {
      //向上
      if (chess.contains(new Point(point.x, point.y - i))) {
        count++;
      } else {
        break;
      }
    }
    if (count > 4) {
      return true;
    }
    for (int i = 1; i < 5; i++) {
      //向下
      if (chess.contains(new Point(point.x, point.y + i))) {
        count++;
      } else {
        break;
      }
    }
    if (count > 4) {
      return true;
    }
    return false;
  }

  //左上右下
  bool checkLeftTopToRightBottom(Point<num> point, List<Point<num>> chess) {
    int count = 1;
    for (int i = 1; i < 5; i++) {
      //向左上
      if (chess.contains(new Point(point.x - i, point.y - i))) {
        count++;
      } else {
        break;
      }
    }
    if (count > 4) {
      return true;
    }
    for (int i = 1; i < 5; i++) {
      //向左
      if (chess.contains(new Point(point.x + i, point.y + i))) {
        count++;
      } else {
        break;
      }
    }
    if (count > 4) {
      return true;
    }
    return false;
  }

//左下右上
  bool checkLeftBottomToRightTop(Point<num> point, List<Point<num>> chess) {
    int count = 1;
    for (int i = 1; i < 5; i++) {
      //向左
      if (chess.contains(new Point(point.x - i, point.y + i))) {
        count++;
      } else {
        break;
      }
    }
    if (count > 4) {
      return true;
    }
    for (int i = 1; i < 5; i++) {
      //向左
      if (chess.contains(new Point(point.x + i, point.y - i))) {
        count++;
      } else {
        break;
      }
    }
    if (count > 4) {
      return true;
    }
    return false;
  }

  bool checkPiece() {
    if (whiteChess.length + blackChess.length == 255) {
      return true;
    }
    return false;
  }
}
