import 'package:flutter/material.dart';

/// Sometime wo need to do something after the build is
/// complete

typedef void AfterLayoutCallback(BuildContext context);

class AfterLayout extends StatelessWidget {

  AfterLayout({
    Key key,
    @required this.callback,
    this.child,
  }) : super(key: key);

  final AfterLayoutCallback callback;
  final Widget child;


  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (callback != null) {
        callback(context);
      }
    });
    return child;
  }
}
