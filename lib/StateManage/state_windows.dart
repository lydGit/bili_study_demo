import 'package:bili_study_demo/StateManage/state_model.dart';
import 'package:flutter/material.dart';
import '../my_app_bar.dart';
import '../windows.dart';
import 'package:scoped_model/scoped_model.dart';

class StateWindows extends MWindows {
  //静态界面
  final String TITLE_STATIC = "静态界面，界面UI不会根据数据变化而变化";

  //动态界面
  final String TITLE_DYNAMIC = "动态界面，数据变化时，自动通知界面UI发生变化";

  //动态界面(数据穿透传递)
  final String TITLE_PIERCE = "动态界面，数据变化时，可以直接通知子控件刷新数据";

  //动态界面(数据使用ScopedModel来进行管理)
  final String TITLE_MODEL = "数据使用ScopedModel来进行管理,数据变更时UI会自定跟着变化";

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
            ),
            new GestureDetector(
              child: Text(
                TITLE_PIERCE,
                style: TextStyle(fontSize: 16),
              ),
              onTap: () =>
                  StateManageDemo3().skip(context, title, TITLE_PIERCE),
            ),
            new GestureDetector(
              child: Text(
                TITLE_MODEL,
                style: TextStyle(fontSize: 16),
              ),
              onTap: () => StateManageDemo4().skip(context, title, TITLE_MODEL),
            ),
          ],
        ),
      ),
    );
  }
}

//************************** StateManageDemo1 ******************************//

class StateManageDemo1 extends StatelessWidget {
  void skip(BuildContext context, String title, String msg) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => StateManageDemo1(
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
            debugPrint("StateManageDemo1 = $index");
          }),
    );
  }
}

//************************** StateManageDemo2 ******************************//

class StateManageDemo2 extends StatefulWidget {
  void skip(BuildContext context, String title, String msg) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => StateManageDemo2(
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

  _StateManageDemo2State(
    this.title,
    this.msg,
  );

  void _increaseCount() {
    //在该方法中刷新数据，会通知界面UI发生变化
    setState(() {
      _index += 1;
    });
    debugPrint("StateManageDemo2 = $_index");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: MyAppBar(
        title: title,
        msg: msg,
      ),
      body: CounterWrapper2(_index, _increaseCount),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
        onPressed: _increaseCount,
      ),
    );
  }
}

class CounterWrapper2 extends StatelessWidget {
  final int index;

  final VoidCallback increaseCount;

  CounterWrapper2(this.index, this.increaseCount);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Counter2(index, increaseCount),
    );
  }
}

///数字lebel
class Counter2 extends StatelessWidget {
  final int index;

  final VoidCallback increaseCount;

  Counter2(this.index, this.increaseCount);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ActionChip(
      backgroundColor: Colors.green,
      autofocus: true,
      onPressed: increaseCount,
      padding: EdgeInsets.all(20),
      label: Text(
        "$index",
        style: TextStyle(fontSize: 80, color: Colors.white),
      ),
    );
  }
}

//************************** StateManageDemo3 ******************************//

class StateManageDemo3 extends StatefulWidget {
  void skip(BuildContext context, String title, String msg) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => StateManageDemo3(
              title: title,
              msg: msg,
            )));
  }

  String title;
  String msg;

  StateManageDemo3({Key key, this.title, this.msg}) : super(key: key);

  @override
  _StateManageDemo3State createState() => _StateManageDemo3State(title, msg);
}

class _StateManageDemo3State extends State<StateManageDemo3> {
  String title;
  String msg;
  int _index = 0;

  _StateManageDemo3State(
    this.title,
    this.msg,
  );

  void _increaseCount() {
    //在该方法中刷新数据，会通知界面UI发生变化
    setState(() {
      _index += 1;
    });
    debugPrint("StateManageDemo3 = $_index");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CounterProvider3(
      index: _index,
      increaseCount: _increaseCount,
      child: Scaffold(
        appBar: MyAppBar(
          title: title,
          msg: msg,
        ),
        body: CounterWrapper3(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.red,
          onPressed: _increaseCount,
        ),
      ),
    );
  }
}

class CounterWrapper3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Counter3(),
    );
  }
}

///数字lebel
class Counter3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int index = CounterProvider3.of(context).index;
    final VoidCallback increaseCount =
        CounterProvider3.of(context).increaseCount;

    // TODO: implement build
    return ActionChip(
      backgroundColor: Colors.red,
      autofocus: true,
      onPressed: increaseCount,
      padding: EdgeInsets.all(20),
      label: Text(
        "$index",
        style: TextStyle(fontSize: 80, color: Colors.white),
      ),
    );
  }
}

class CounterProvider3 extends InheritedWidget {
  final int index;
  final VoidCallback increaseCount;
  final Widget child;

  CounterProvider3({this.index, this.increaseCount, this.child})
      : super(child: child);

  static CounterProvider3 of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(CounterProvider3);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return true;
  }
}

//************************** StateManageDemo4 ******************************//

class StateManageDemo4 extends StatelessWidget {
  void skip(BuildContext context, String title, String msg) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => StateManageDemo4(
              title: title,
              msg: msg,
            )));
  }

  String title;
  String msg;

  StateManageDemo4({Key key, this.title, this.msg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModel(
      model: StateModel(),
      child: Scaffold(
        appBar: MyAppBar(
          title: title,
          msg: msg,
        ),
        body: CounterWrapper4(),
        floatingActionButton: ScopedModelDescendant<StateModel>(
          ///表示数据变化，也不需要重构当前以下的小部件
          rebuildOnChange: false,

          ///_：表示可选的子部件
          builder: (context, _, model) => FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Colors.blue,
            onPressed: model.increaseCount,
          ),
        ),
      ),
    );
  }
}

class CounterWrapper4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Counter4(),
    );
  }
}

///数字lebel
class Counter4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModelDescendant<StateModel>(
      builder: (context, _, model) => ActionChip(
        backgroundColor: Colors.blue,
        autofocus: true,
        onPressed: model.increaseCount,
        padding: EdgeInsets.all(20),
        label: Text(
          "${model.index}",
          style: TextStyle(fontSize: 80, color: Colors.white),
        ),
      ),
    );
  }
}
