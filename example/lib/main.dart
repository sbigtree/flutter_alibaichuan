import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:alibaichuan/alibaichuan.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  MethodChannel taobaosdk = const MethodChannel('taobaosdk');

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    print('开始');

    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
//    try {
//      platformVersion = await Alibaichuan.platformVersion;
//      print('开始---');
//    } on PlatformException {
//      platformVersion = 'Failed to get platform version.';
//    }
    var res = await Alibaichuan.init;
    print('初始化---->>> $res');

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
          brightness: Brightness.dark,
        ),
        body: Container(
            child: Column(
          children: <Widget>[
            MyTabBar(),
            FlatButton(
              onPressed: () async {


                var res = await Alibaichuan.login;
                print('--登录--->> $res');
              },
              child: Text('登录'),
            ),
            FlatButton(
              onPressed: () async {

                var res = await Alibaichuan.logout;
                print('--登出--->> $res');
              },
              child: Text('登出'),
            ),
            FlatButton(
              onPressed: () async {
                var url = 'https://uland.taobao.com/coupon/edetail?e=ZHFvM9aiC3gGQASttHIRqcFsNdUdHscCORFRYj99i%2FaV0BfRUdYksTJzOdZW4ZmL%2BXwycF4RO%2F0GE%2FyxgZXxsY58WXO9bK50Wv9OAj9evKDahba4h8MrZ%2Bdth9k8bqqSHKTgBzHkoM7XTQC0vfau6E%2F9Zk7cDx8UPrKiYwdarE%2FmZlrHb6YhPHui%2Fn%2FQ7Z5Vsay%2Fb2KUBBWA9F9OCeGtkw%3D%3D&traceId=0b15099115872179615955959e&union_lens=lensId:0b581b6f_0e57_1718d901300_8057&xId=qT7Wt4Gyr0M4d12agkrNr2uM5snBbaOw9QtcpA2QRLAgNDUP4MyM5kfllB3F3Da8juchlFHxnr9jhQbqQd2sDG&activityId=a4a9af2b81d148f3974419f377e1473a';
//                url = 'https://s.click.taobao.com/t?e=m%3D2%26s%3DHTetRkMGA1Nw4vFB6t2Z2ueEDrYVVa64LKpWJ%2Bin0XLLWlSKdGSYDtRYi6V2XKlSRitN3%2FurF3w6pccxjrsG1OtJ3tUz5F6EfNH8nm%2BYT1B5PBXhyRVwoh8X7G7Q37BamuEdjFRurlrpxqh64ChbfP1SarTXhIOTrhzfEh3ilxbbJ2%2FqLVUXutkYvQZuIwx3oGeIQL4Fi9E0hua6F%2BxLpa7uozR1qcJEAtuQeASk5p8tzYM';
                var res = await Alibaichuan.openUrl('http://taobao.com');
                print('----->> $res');
              },
              child: Text('打开URL'),
            )
          ],
        )),
      ),
    );
  }
}

class MyTabBar extends StatefulWidget {
  @override
  _MyTabBarState createState() => _MyTabBarState();
}

class _MyTabBarState extends State<MyTabBar>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tabbats = List();
    for (var i = 0; i < 4; i++) {
      Container con = Container(
        child: Column(
          children: <Widget>[
            Text(
              '${i + 1}',
              style: TextStyle(fontSize: 32, color: Colors.red),
            ),
          ],
        ),
      );
      tabbats.add(con);
    }

    return Container(
      child: TabBar(
        controller: tabController,
        tabs: tabbats,
      ),
    );
  }
}
