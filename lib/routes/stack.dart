import 'package:flutter/material.dart';

class StackRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Container(
            height: 200,
            width: 200,
            color: Colors.red,
          ),
          Container(
            height: 170,
            width: 170,
            color: Colors.blue,
          ),
          Positioned(
            left: 30,
            top: 60,
            right: 40,
            bottom: 50,
            child: Container(
              color: Colors.yellow,
            ),
          ),
        ],
      ),
    );
  }
}
