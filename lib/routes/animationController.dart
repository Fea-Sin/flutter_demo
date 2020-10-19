import 'package:flutter/material.dart';

class AnimationBaseRoute extends StatefulWidget {
  @override
  _AnimationBaseRouteState createState() => _AnimationBaseRouteState();
}

class _AnimationBaseRouteState extends State<AnimationBaseRoute> with SingleTickerProviderStateMixin {

  double _size = 100.0;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
      lowerBound: 100.0,
      upperBound: 200.0,)
        ..addListener(() {
          setState(() {
            _size = _controller.value;
          });
        });
  }



  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          _controller.forward();
        },
        child: Container(
          height: _size,
          width: _size,
          color: Colors.blue,
          alignment: Alignment.center,
          child: Text('点我变大',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
