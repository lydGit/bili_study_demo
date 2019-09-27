import 'package:flutter/material.dart';

import '../my_app_bar.dart';
import '../windows.dart';
import 'dart:async';

class StreamWindows extends MWindows {
  StreamWindows({String title, String msg}) : super(title, msg);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: MyAppBar(
        title: title,
        msg: msg,
      ),
      body: StreamDemoHome(),
    );
  }
}

class StreamDemoHome extends StatefulWidget {
  @override
  _StreamDemoHomeState createState() => _StreamDemoHomeState();
}

class _StreamDemoHomeState extends State<StreamDemoHome> {
  ///数据回调订阅器
  StreamSubscription _StreamDemoSubscription;

  ///数据请求控制器
  StreamController<String> _streamDemo;

  ///数据添加器
  StreamSink _sinkDemo;

  String _data = "setState";

  @override
  void dispose() {
    // TODO: implement dispose
    //小部件被移除的时候，需要关闭请求
    _streamDemo.close();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("创建数据加载请求 ~");

    ///实现方法1
//    Stream<String> _streamDemo = Stream.fromFuture(fetchData());
    ///实现方法2
    _streamDemo = StreamController<String>();
    _sinkDemo = _streamDemo.sink;

    print("添加数据加载监听 ~");

    ///onData:数据加载成功 onError:数据加载失败 onDone:数据加载完成(成功失败都会触发)
//    _StreamDemoSubscription =
//        _streamDemo.listen(onData, onError: onError, onDone: onDone);
//    _StreamDemoSubscription =
//        _streamDemo.stream.listen(onData, onError: onError, onDone: onDone);
    print("数据加载请求已发出 ~");
  }

  ///加载数据
  Future<String> fetchData() async {
    //延迟三秒钟
    await Future.delayed(Duration(seconds: 5));
//    throw "发生错误";
    print("数据加载完成，准备返回数据");
    return "加载成功 ~";
  }

  ///数据加载成功
  void onData(String data) {
    print("$data");
    setState(() {
      _data = data;
    });
  }

  ///数据加载失败(error不能注明类型，否则会报错)
  void onError(error) {
    print("Error: $error");
  }

  ///数据加载完成(成功失败都会触发)
  void onDone() {
    print("Done");
  }

  ///暂停订阅
  void _onPause() {
    print("暂停订阅");

    ///暂停订阅，暂停不会停止数据的加载。
    ///当恢复订阅的时候，如果数据加载已经完成会马上触发回调
    _StreamDemoSubscription.pause();
  }

  ///恢复订阅
  void _onResume() {
    print("恢复订阅");

    ///恢复暂停中的订阅
    _StreamDemoSubscription.resume();
  }

  ///取消订阅
  void _onCancel() {
    print("取消订阅");

    ///可以在运行/暂停的状态下取消订阅，取消后不能恢复。
    ///取消不会影响数据的加载，只是无法触发回调
    _StreamDemoSubscription.cancel();
  }

  ///添加数据到StreamController中
  void _onAddData() async {
    print("添加数据到StreamController中");
    String data = await fetchData();

    ///方法1
//    _streamDemo.add(data);
    ///方法2
    _sinkDemo.add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("setState刷新小部件数据 :$_data"),
            //通过StreamBuilder刷新小部件
            StreamBuilder(
              //Stream一次只能设置一个订阅
              stream: _streamDemo.stream,
              initialData: "StreamBuilder",
              builder: (context, snapshot) {
                return Text("StreamBuilder刷新小部件数据 :${snapshot.data}");
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  child: Text("添加数据"),
                  onPressed: _onAddData,
                ),
                FlatButton(
                  child: Text("暂停"),
                  onPressed: _onPause,
                ),
                FlatButton(
                  child: Text("恢复"),
                  onPressed: _onResume,
                ),
                FlatButton(
                  child: Text("取消"),
                  onPressed: _onCancel,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
