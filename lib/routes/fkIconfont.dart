import 'package:flutter/material.dart';

class FkIconfontRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            width: 100,
            height: 50,
            child: new Icon(IconData(0xe659, fontFamily: 'FkIconfont'), size: 20, color: Colors.red,),
          ),
          Container(
            width: 100,
            height: 50,
            child: new Icon(IconData(0xe619, fontFamily: 'FkIconfont'), size: 20,),
          ),
        ],
      ),
    );
  }
}
