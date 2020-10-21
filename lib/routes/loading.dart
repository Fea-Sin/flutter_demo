import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: SizedBox(
              child: LinearProgressIndicator(),
            ),
          ),
          Container(
            child: LinearProgressIndicator(
              value: 0.3,
              backgroundColor: Colors.greenAccent,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
            ),
          ),
          Container(
            child: CircularProgressIndicator(),
          ),
          Container(
            height: 200,
            child: CupertinoActivityIndicator(
              radius: 10,
            ),
          ),
          Container(
            child: RefreshProgressIndicator(),
          ),
        ],
      ),
    );
  }
}



