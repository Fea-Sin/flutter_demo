import 'dart:async';
import 'package:flutter/material.dart';

class OneStateRoute extends StatefulWidget {

  final String text;

  // 构造函数传值
  OneStateRoute({this.text});

  @override
  _OneStateRouteState createState() => _OneStateRouteState();
}

class _OneStateRouteState extends State<OneStateRoute> {

  String text;

  _OneStateRouteState({this.text});

  @override
  void initState() {
    // 初始化，这个函数在生命周期中只调用一次
    super.initState();

    new Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        text = '数值会变';
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // 在initState之后调 Called when a dependency of this [state] object changes
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(text ?? '这里是初始值DEMO'),
    );
  }
}
