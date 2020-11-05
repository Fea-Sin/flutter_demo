import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const Spinkit = SpinKitRotatingCircle(
  color: Colors.red,
  size: 50.0,
);
const SpinkitHeart = SpinKitPumpingHeart(color: Colors.red);

class SpinkitRoute extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text('spinkit loading'),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
//            color: Colors.red,
            child: Spinkit,
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: SpinkitHeart,
          ),
        ],
      ),
    );
  }
}
