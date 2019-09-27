import 'package:flutter/material.dart';

import '../my_app_bar.dart';
import '../windows.dart';

class BlocWindows extends MWindows {
  BlocWindows({String title, String msg}) : super(title, msg);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: MyAppBar(
        title: title,
        msg: msg,
      ),
    );
  }
}
