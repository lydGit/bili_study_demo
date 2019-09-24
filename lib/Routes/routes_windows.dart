import 'package:flutter/material.dart';
import '../my_app_bar.dart';
import '../windows.dart';

///路由器界面
class RoutesWindows extends MWindows {
  RoutesWindows({String title, String msg}) : super(title, msg);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: MyAppBar(
        title: title,
        msg: msg,
      ),
      body: NavigatorDemo1(),
    );
  }
}

///跳转页面
class NavigatorDemo1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        //垂直剧中
        mainAxisAlignment: MainAxisAlignment.center,
        //水平剧中
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          new FlatButton(
              //跳转界面
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => NavigatorDemo2(title: "直接跳转",))),
              child: Text(
                "跳转页面1",
                style: TextStyle(fontSize: 40),
              )),
          new FlatButton(
              //跳转界面
              onPressed: () => Navigator.pushNamed(context, "/NavigatorDemo2",),
              child: Text(
                "跳转页面2",
                style: TextStyle(fontSize: 40),
              )),
        ],
      ),
    );
  }
}

///跳转目标页面
class NavigatorDemo2 extends StatelessWidget {
  String title;

  NavigatorDemo2({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () =>
              //关闭界面
              Navigator.pop(context),
          child: Text(
            title,
            style: TextStyle(fontSize: 40),
          ),
        ),
      ),
    );
  }
}
