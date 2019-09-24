import 'package:bili_study_demo/StateManage/state_windows.dart';
import 'package:bili_study_demo/windows.dart';
import 'Routes/routes_windows.dart';

final List<MWindows> Windows = [
  RoutesWindows(
    title: "路由器使用",
    msg: "使用路由器的方式进行跳转",
  ),
  StateWindows(
    title: "状态管理",
    msg: "StatelessWidget/StatefulWidget，小部件里面的数据管理",
  ),
];
