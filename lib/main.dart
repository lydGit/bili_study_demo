import 'package:flutter/material.dart';
import 'package:bili_study_demo/windows_list.dart';

import 'Routes/routes_windows.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //初始路由(确定App第一个启动界面，通过名称确定，如果不设置使用的会是runApp中指定的)
//      initialRoute: "init",
      routes: {
        "init": (context) => NavigatorDemo1(),
        //使用名称的路由跳转，貌似只能在App第一个MaterialApp中添加（添加到其他MaterialApp中没有效果）
        "/NavigatorDemo2": (context) => NavigatorDemo2(title: "使用名称的路由跳转"),
      },
      home: Scaffold(
        appBar: AppBar(
          title: Text("BiliBili项目学习"),
        ),
        body: ListView.builder(
          itemCount: Windows == null ? 0 : Windows.length,
          itemBuilder: (context, index) {
            return new ListTile(
                title: new Text('${Windows[index].title}'),
                subtitle: Text('${Windows[index].msg}'),
                //使文本更小，并将所有内容打包在一起
                dense: true,
                //设置拖尾将在列表的末尾放置一个图像
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  print("点击"+index.toString()+"  "+Windows[index].title);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Windows[index]));
                });
          },
        ),
      ),
    );
  }
}
