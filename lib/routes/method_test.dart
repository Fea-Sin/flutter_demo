import 'package:flutter/material.dart';

class MethodRoute extends StatefulWidget {
  @override
  _MethodRouteState createState() => _MethodRouteState();
}

class _MethodRouteState extends State<MethodRoute> {

  @override
  void initState() {
    super.initState();
    print('initState====0');
  }

  @override
  void dispose() {
    print('dispose====2');
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    /// Called when a dependency of this State object changes
    ///
    /// This method is also called immediately after initState.

    super.didChangeDependencies();

    print('didChangeDependencies===1');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('声明周期方法测试'),
    );
  }
}
