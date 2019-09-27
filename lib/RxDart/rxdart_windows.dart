import 'package:flutter/material.dart';

import '../my_app_bar.dart';
import '../windows.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

class RxDartWindow extends MWindows {
  RxDartWindow({String title, String msg}) : super(title, msg);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: MyAppBar(
        title: title,
        msg: msg,
      ),
      body: RxDartHome(),
    );
  }
}

class RxDartHome extends StatefulWidget {
  @override
  _RxDartHomeState createState() => _RxDartHomeState();
}

class _RxDartHomeState extends State<RxDartHome> {
  PublishSubject<String> _textFieldSubject;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

//    Observable<String> _observable =
//        Observable(Stream.fromIterable(["Hello", "您好"]));
//        Observable.fromFuture(Future.value("hello ~ "));
//        Observable.fromIterable(["Hello.", "您好"]);
//        Observable.just("hello !");
    ///间隔3秒，重复执行(一开始就会间隔)
//        Observable.periodic(Duration(seconds: 3), (x) => x.toString());
//    _observable.listen(print);

//    PublishSubject<String> _subject = PublishSubject<String>();
//    _subject.listen((data) => print('listener 1 $data'));
//    _subject.add("hello1");
//    _subject.listen((data) => print('listener 2 $data.toUpperCase()'));
//    _subject.add("hello2");
//    _subject.close();

//    BehaviorSubject<String> _subject = BehaviorSubject<String>();
//    _subject.add("hello1");
//    _subject.add("hello2");
//    _subject.listen((data) => print('listener 1 $data'));
//    _subject.listen((data) => print('listener 2 $data.toUpperCase()'));
//    _subject.close();

//    ReplaySubject<String> _subject = ReplaySubject<String>(maxSize: 2);
//    _subject.add("hello1");
//    _subject.add("hello2");
//    _subject.add("hello3");
//    _subject.listen((data) => print('listener 1 $data'));
//    _subject.listen((data) => print('listener 2 $data.toUpperCase()'));
//    _subject.close();

    _textFieldSubject = PublishSubject<String>();
    _textFieldSubject
        ///处理数据方法(item:接收的数据)
//        .map((item)=>'item : $item')
        ///设置数据条件
//        .where((item)=>item.length>9)
        ///当输入框不断输入数据时，不会触发回调。当停下来有500毫秒后才会执行
        .debounce(Duration(milliseconds: 500))
        .listen((data) => print(data));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _textFieldSubject.close();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        _textFieldSubject.add('input $value');
      },
      onSubmitted: (value) {
        _textFieldSubject.add('submit $value');
      },
      decoration: InputDecoration(
        labelText: "Title",
        filled: true,
      ),
    );
  }
}
