import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as prefix0;
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix1;
import 'dart:ui' ;

import 'package:flutter/services.dart';
import 'package:games/utils.dart';

class WuZiQiView extends CustomPainter {
  double padding;
  double gridWidth;
  static const BORDER_NUM = 15;
  final Paint mPaint = Paint();
  List<Point> blackChess;
  List<Point> whiteChess;

  WuZiQiView(this.blackChess, this.whiteChess);

  @override
  void paint(Canvas canvas, Size size) {
    mPaint.isAntiAlias = true;

    drawBorder(canvas, mPaint, size);
    drawChess(canvas,mPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  @override
  void addListener(listener) {
    super.addListener(listener);
  }

  void drawBorder(Canvas canvas, Paint paint, Size size) {
    paint.strokeWidth = 0.5;
    paint.color = Colors.black87;
    paint.style = PaintingStyle.fill;
    double width = size.width < size.height ? size.width : size.height;
    gridWidth = width / BORDER_NUM;
    padding = gridWidth / 2;

    for (int i = 0; i < 15; i++) {
      //画横线
      if(i==0||i==14){
        paint.strokeWidth=2;
      }else{
        paint.strokeWidth=0.5;
      }
      canvas.drawLine(Offset(padding, padding + gridWidth * i),
          Offset(width - padding, padding + gridWidth * i), paint);
      //画横线
      canvas.drawLine(Offset(padding + gridWidth * i, padding),
          Offset(padding + gridWidth * i, width - padding), paint);
    }
    canvas.drawCircle(Offset(gridWidth*3+padding, gridWidth*3+padding), gridWidth*0.1, paint);
    canvas.drawCircle(Offset(gridWidth*3+padding, gridWidth*7+padding), gridWidth*0.1, paint);
    canvas.drawCircle(Offset(gridWidth*3+padding, gridWidth*11+padding), gridWidth*0.1, paint);
    canvas.drawCircle(Offset(gridWidth*7+padding, gridWidth*3+padding), gridWidth*0.1, paint);
    canvas.drawCircle(Offset(gridWidth*7+padding, gridWidth*7+padding), gridWidth*0.1, paint);
    canvas.drawCircle(Offset(gridWidth*7+padding, gridWidth*11+padding), gridWidth*0.1, paint);
    canvas.drawCircle(Offset(gridWidth*11+padding, gridWidth*3+padding), gridWidth*0.1, paint);
    canvas.drawCircle(Offset(gridWidth*11+padding, gridWidth*7+padding), gridWidth*0.1, paint);
    canvas.drawCircle(Offset(gridWidth*11+padding, gridWidth*11+padding), gridWidth*0.1, paint);
  }


  void drawChess(Canvas canvas, Paint mPaint) async{
    print("黑棋：$blackChess");
    print("白棋：$whiteChess");
    blackChess.forEach((point){
      mPaint.color=Colors.black87;
      canvas.drawCircle(Offset(point.x*gridWidth+padding,padding+point.y*gridWidth), gridWidth/2*0.8, mPaint);
    });
    whiteChess.forEach((point){
      mPaint.color=Colors.white;
      canvas.drawCircle(Offset(point.x*gridWidth+padding,padding+point.y*gridWidth), gridWidth/2*0.8, mPaint);
    });
  }
}
