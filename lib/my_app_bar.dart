import 'package:flutter/material.dart';

///自定义标题栏（点击标题可以返回上个界面）
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  String title;

  String msg;

  MyAppBar({Key key, this.title, this.msg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Widget appBar = new Container(
      padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          new Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          new Text(
            msg,
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );

    //实现沉淀式菜单栏
    appBar = SafeArea(
      top: true,
      child: appBar,
    );

    return new Container(
      color: Theme.of(context).primaryColor,
      //添加点击事件
      child: GestureDetector(
        child: appBar,
        //关闭当前弹窗
        onTap: () => Navigator.pop(context),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
