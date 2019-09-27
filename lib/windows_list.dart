import 'package:bili_study_demo/StateManage/state_windows.dart';
import 'package:bili_study_demo/stream/stream_windows.dart';
import 'package:bili_study_demo/windows.dart';
import 'BloC/bloc_windows.dart';
import 'Routes/routes_windows.dart';
import 'RxDart/rxdart_windows.dart';

// ignore: non_constant_identifier_names
final List<MWindows> Windows = [
  RoutesWindows(
    title: "路由器使用",
    msg: "使用路由器的方式进行跳转",
  ),
  StateWindows(
    title: "状态管理",
    msg: "StatelessWidget/StatefulWidget，小部件里面的数据管理",
  ),
  StreamWindows(
    title: "Stream的使用",
    msg: "使用Stream来传输数据，有点像EventBus",
  ),
  RxDartWindow(
    title: "RxDart的使用",
    msg: "RxDart",
  ),
  BlocWindows(
    title: "Bloc的使用",
    msg: "Bloc",
  ),
];
