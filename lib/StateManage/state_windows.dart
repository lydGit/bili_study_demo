import 'package:flutter/material.dart';
import '../my_app_bar.dart';
import '../windows.dart';

class StateWindows extends MWindows {
  //静态界面
  final String TITLE_STATIC = "静态界面，界面UI不会根据数据变化而变化";

  //动态界面
  final String TITLE_DYNAMIC = "动态界面，数据变化时，自动通知界面UI发生变化";

  StateWindows({Key key, String title, String msg}) : super(title, msg);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: MyAppBar(
        title: title,
        msg: msg,
      ),
      body: new Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new GestureDetector(
              child: Text(
                TITLE_STATIC,
                style: TextStyle(fontSize: 16),
              ),
              onTap: () =>
                  StateManageDemo1().skip(context, title, TITLE_STATIC),
            ),
            new GestureDetector(
              child: Text(
                TITLE_DYNAMIC,
                style: TextStyle(fontSize: 16),
              ),
              onTap: () =>
                  StateManageDemo2().skip(context, title, TITLE_DYNAMIC),
            )
          ],
        ),
      ),
    );
  }
}

class StateManageDemo1 extends StatelessWidget {
  void skip(BuildContext context, String title, String msg) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) =>
            StateManageDemo1(
              title: title,
              msg: msg,
            )));
  }

  String title;
  String msg;
  int index = 0;

  StateManageDemo1({Key key, this.title, this.msg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: MyAppBar(
        title: title,
        msg: msg,
      ),
      body: Center(
          child: Chip(
            label: Text("$index"),
          )),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            index += 1;
            debugPrint("index = $index");
          }),
    );
  }
}

class StateManageDemo2 extends StatefulWidget {
  void skip(BuildContext context, String title, String msg) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) =>
            StateManageDemo2(
              title: title,
              msg: msg,
            )));
  }

  String title;
  String msg;

  StateManageDemo2({Key key, this.title, this.msg}) : super(key: key);

  @override
  _StateManageDemo2State createState() => _StateManageDemo2State(title, msg);
}

class _StateManageDemo2State extends State<StateManageDemo2> {
  String title;
  String msg;
  int _index = 0;

  _StateManageDemo2State(this.title,
      this.msg,);

  void _increaseCount(){
    //在该方法中刷新数据，会通知界面UI发生变化
    setState(() {
      _index += 1;
    });
    debugPrint("index = $_index");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: MyAppBar(
        title: title,
        msg: msg,
      ),
      body: Counter(_index,_increaseCount),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.green,
          onPressed: _increaseCount,
          ),
    );
  }
}

///数字lebel
class Counter extends StatelessWidget {
  final int index;

  final VoidCallback increaseCount;

  Counter(this.index, this.increaseCount);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: ActionChip(
        backgroundColor: Colors.green,
        autofocus: true,
        onPressed:increaseCount,
        padding: EdgeInsets.all(20),
        label: Text(
          "$index",
          style: TextStyle(fontSize: 80, color: Colors.white),
        ),
      ),
    );
  }
}
