import 'dart:math';
import 'package:flutter/material.dart';
import '../widgets/turn_box.dart';

class TurnBoxRoute extends StatefulWidget {
  @override
  _TurnBoxRouteState createState() => _TurnBoxRouteState();
}

class _TurnBoxRouteState extends State<TurnBoxRoute> {

  double _turns = .0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          TurnBox(
            turns: _turns,
            speed: 600,
            child: Icon(Icons.refresh),
          ),
          TurnBox(
            turns: _turns,
            speed: 400,
            child: Icon(Icons.refresh, size: 50.0),
          ),
          RaisedButton(
            child: Text('Clockwise'),
            onPressed: () {
              setState(() {
                _turns += .25;
              });
            },
          ),
          RaisedButton(
            child: Text('Anti-clockwise'),
            onPressed: () {
              setState(() {
                _turns -= .25;
              });
            },
          )
        ],
      ),
    );
  }
}
