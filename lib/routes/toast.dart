import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../core/utils/toast.dart';

class ToastRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Column(
        children: <Widget>[
          Center(
            child: CupertinoButton(
              child: Text('ios 风格按钮'),
              onPressed: () {
                ToastUtils.toast('程序运行');
              },
              color: Colors.blue,
              pressedOpacity: 0.5,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: CupertinoButton(
              child: Text('success 风格'),
              onPressed: () {
                ToastUtils.success('程序运行');
              },
              color: Colors.blue,
              pressedOpacity: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
