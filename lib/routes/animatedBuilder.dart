import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedBuilderRoute extends StatefulWidget {
  @override
  _AnimatedBuilderRouteState createState() => _AnimatedBuilderRouteState();
}

class _AnimatedBuilderRouteState extends State<AnimatedBuilderRoute> with TickerProviderStateMixin {

  AnimationController animationController;
  Animation animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this,
        duration: Duration(seconds: 2),)
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            animationController.reverse();
          } else if (status == AnimationStatus.dismissed) {
            animationController.forward();
          }
        });
    animation = Tween(begin: 0.0, end: 2.0*pi).animate(animationController);
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget child) {
          return Transform.rotate(
            angle: animation.value,
            child: child,
          );
        },
        child: FlutterLogo(size: 60,),
      ),
    );
  }
}
