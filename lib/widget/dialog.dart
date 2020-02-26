

import 'package:flutter/material.dart';

class MyDialog extends StatelessWidget{
  VoidCallback sure;
  VoidCallback cancel;
  MyDialog(this.sure,this.cancel);
  @override
  Widget build(BuildContext context) {

    Widget widget=
    Card(
      child: Column(
        mainAxisAlignment:MainAxisAlignment.center,
        children: <Widget>[
          Text("游戏结束"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[

            FlatButton(onPressed: cancel, child: Text("取消")),
            FlatButton(onPressed: sure, child: Text("确定")),
          ],)
        ],
      ),

    );


    return Container(
      width: MediaQuery.of(context).size.width*0.6,
      height: MediaQuery.of(context).size.width*0.3,
      child: widget,

    );
  }

}