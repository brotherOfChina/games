import 'package:flutter/material.dart';
import 'package:games/wzq/wzq_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {WuZiQi.ROUTE_NAME: (BuildContext context) => new WuZiQi()},
      title: '游戏',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '游戏'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GridView.count(
        crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        padding: EdgeInsets.all(10),
        children: <Widget>[
          GestureDetector(
            child: Card(
              margin: EdgeInsets.all(10),

              child:Center(
                child: Text("五子棋"),
              ) ,
              elevation: 4,
            ),
            onTap: () {
              Navigator.pushNamed(context, WuZiQi.ROUTE_NAME);
            },
          ),
          GestureDetector(
            child: Card(
              margin: EdgeInsets.all(10),

              child:Center(
                child: Text("五子棋"),
              ) ,
              elevation: 4,
            ),
            onTap: () {
              Navigator.pushNamed(context, WuZiQi.ROUTE_NAME);
            },
          ),
          GestureDetector(
            child: Card(
              margin: EdgeInsets.all(10),

              child:Center(
                child: Image.asset("imgs/white.jpg"),
              ) ,
              elevation: 4,
            ),
            onTap: () {
              Navigator.pushNamed(context, WuZiQi.ROUTE_NAME);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
